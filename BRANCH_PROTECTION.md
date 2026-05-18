# Branch Protection — Pflicht-Setup fuer dieses Repo

Diese Einstellungen koennen NICHT in einem Commit gesetzt werden — sie
muessen einmalig in der GitHub-Weboberflaeche oder per `gh api` aktiviert
werden. Ohne sie ist die `main`-Branch force-pushbar und der Audit-Trail
(`AI-PROVENANCE.md`, CRA-relevant!) angreifbar.

## Variante A — GitHub-UI (3 Minuten)

1. Im Browser zu **`Settings -> Branches`** navigieren
2. **`Add branch ruleset`** klicken
3. Konfiguration:

   **Name:** `Protect main`

   **Enforcement status:** Active

   **Targets:** Default branch (`main`)

   **Branch protections** — folgende aktivieren:

   - [x] **Restrict creations** — kein versehentliches Neuanlegen
   - [x] **Restrict updates** — Force-Push verboten
   - [x] **Restrict deletions** — main kann nicht geloescht werden
   - [x] **Require linear history** — keine Merge-Commits, kein History-Rewrite
   - [x] **Require signed commits** — alle Commits muessen GPG/SSH-signiert sein

   **Require a pull request before merging:**
   - [x] Required approvals: **1**
   - [x] Dismiss stale pull request approvals when new commits are pushed
   - [x] Require review from Code Owners (falls `CODEOWNERS`-Datei vorhanden)

   **Require status checks to pass:**
   - [x] Require branches to be up to date before merging
   - Required checks:
     - `Repo Validator` (aus `.github/workflows/validate.yml`)
     - `AI-PROVENANCE Integrity` (aus `.github/workflows/provenance-integrity.yml`)

   **Block force pushes:** activated.

4. **Speichern**

## Variante B — `gh` CLI (1 Minute)

Voraussetzung: `gh` installiert + authentifiziert mit Admin-Rechten auf dem Repo.

```bash
# Branch-Ruleset via API
gh api -X POST repos/mtmatefi/ai-agency/rulesets \
  -H "Accept: application/vnd.github+json" \
  -f name='Protect main' \
  -f target='branch' \
  -f enforcement='active' \
  -F conditions[ref_name][include][]='~DEFAULT_BRANCH' \
  -F rules[][type]='deletion' \
  -F rules[][type]='non_fast_forward' \
  -F rules[][type]='required_linear_history' \
  -F rules[][type]='required_signatures' \
  -F rules[][type]='pull_request' \
  -F rules[][parameters][required_approving_review_count]=1 \
  -F rules[][type]='required_status_checks' \
  -F rules[][parameters][required_status_checks][][context]='Repo Validator' \
  -F rules[][parameters][required_status_checks][][context]='AI-PROVENANCE Integrity'
```

(JSON-API verlangt etwas mehr Schreibarbeit als oben dargestellt — bei
Konflikten Variante A nutzen.)

## Warum jedes Setting

| Setting | Warum wichtig |
|---------|---------------|
| Restrict updates / Block force pushes | Verhindert History-Rewrite. Pflicht fuer CRA-Audit-Trail (10 Jahre). |
| Require linear history | Erleichtert `git log` als Audit-Trail. Keine versteckten Merge-Commits. |
| Require signed commits | Beweist Identitaet des Committers. Pflicht wenn Code/Provenance rechtsverbindlich sein soll. |
| Require PR + 1 approval | Kein Self-Merge. Auch fuer Solo-Repos sinnvoll: zwingt zu kurzer Pause + Selbst-Review. |
| Require status checks | `validate.yml` + `provenance-integrity.yml` MUESSEN gruen sein vor Merge. |
| Dismiss stale approvals | Schiebt-jemand-noch-was-rein-vor-Merge-Problem geloest. |

## Signed Commits — Setup (einmalig)

```bash
# GPG-Key generieren (falls noch keiner da)
gpg --full-generate-key  # ECC (Curve 25519), 0 = nie ablaufen

# Public Key fuer GitHub exportieren
gpg --armor --export YOUR_KEY_ID
# -> in GitHub Settings -> SSH and GPG keys -> New GPG key

# Git konfigurieren
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true
git config --global tag.gpgsign true
```

Alternative: SSH-Signing (einfacher, nutzt vorhandene SSH-Keys):
```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

## Pruefen ob die Schutzmassnahmen aktiv sind

```bash
gh api repos/mtmatefi/ai-agency/rulesets --jq '.[] | {name, enforcement, rules: .rules | length}'
```

Erwartete Ausgabe:
```
{ "name": "Protect main", "enforcement": "active", "rules": 6 }
```

---

## Zusaetzlich: Pre-Commit-Hook im Zielprojekt aktivieren (Client-Side Schutz)

Damit lokale Modifikationen von `AI-PROVENANCE.md` bereits VOR dem Commit
blockiert werden (statt erst auf GitHub via PR-Workflow), kann jeder Nutzer
einen Pre-Commit-Hook aktivieren. Der Hook ist als Template ausgeliefert,
**aktivieren bleibt manuelle Entscheidung** (kein Auto-Installer — der
Nutzer soll sehen was er einbaut):

```bash
# Im Zielprojekt (nicht im Agency-Repo)
mkdir -p .githooks
cp .agency/templates/githooks/pre-commit .githooks/
chmod +x .githooks/pre-commit
git config core.hooksPath .githooks
```

```powershell
# Windows / PowerShell-Aequivalent
New-Item -ItemType Directory -Force -Path .githooks | Out-Null
Copy-Item .agency\templates\githooks\pre-commit .githooks\pre-commit -Force
# Auf Windows nicht executable noetig (Git-for-Windows respektiert shebang)
git config core.hooksPath .githooks
```

Was der Hook tut: Bei jedem `git commit` wird geprueft, ob `AI-PROVENANCE.md`
gestagete Aenderungen enthaelt, die bestehende Zeilen aendern oder loeschen.
Wenn ja -> Commit wird abgelehnt mit klarem Hinweis.

Bypass in echtem Notfall (z.B. Repo-Migration mit Datums-Korrektur):
```bash
git commit --no-verify -m "..."  # Begruendung im PR dokumentieren!
```

Der Server-Side-Workflow `provenance-integrity.yml` faengt das ggf. auf
GitHub-Seite trotzdem ab — beide Schichten zusammen sind die Defense-in-Depth.
