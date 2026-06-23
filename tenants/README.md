<!-- @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Agency Director + Kai Bauer -->
<!-- @ai-date: 2026-06-23 -->
<!-- @ai-task: Architektur-Doku Mandantenfaehigkeit (Multi-Tenancy) -->
<!-- @human-review: OFFEN bis mtmatefi Sign-Off -->

# Mandantenfaehigkeit (Multi-Tenancy)

Wie ein Kunde (Mandant) eigene Standards, ein eigenes Design-System und einen
eigenen UX-Kundenkreis bekommt — ohne die geteilte Engine zu duplizieren.

## Das Schichten-Modell

```
Basis (mtmatefi/ai-agency, CLAUDE.md + 14 Teams)   geteilt, DRY
        v  ueberschrieben/erweitert von
Profil (Projekt-TYP: saas-eu-b2b, internal-tool …)  was bereits existiert
        v
MANDANT (KUNDE: pilatus, gesellschaftsbecken …)     diese Ebene
        v
Projekt-lokale Overrides                             optional
```

Precedence: **Mandant > Profil > Basis**. Aber mit **Override-Floor** — ein
Mandant darf nur *verschaerfen*, nie unter das Sicherheits-/Compliance-/Provenance-
Minimum absenken (Details: `CLAUDE.md` -> `MANDANTEN-MODUS`).

## Zwei Quellen, die unabhaengig updaten

```
1) ENGINE  — mtmatefi/ai-agency  (geteilt)
   14 Teams, CLAUDE.md, Profile, Validator
   -> aendert sich selten, betrifft ALLE Kunden

2) MANDANT — agency-tenant-<kunde>  (privat, 1 Repo pro Kunde)
   nur Deltas: standards / design-system / ux / brand-voice
   -> aendert sich pro Kunde, betrifft nur dessen Projekte
```

Ein Kundenprojekt zieht via `update.{sh,ps1}` aus **beiden**: erst Engine nach
`.agency/`, dann (falls `tenant` konfiguriert) das Overlay nach `.agency/tenant/`.

```
            mtmatefi/ai-agency ─────────────┐ (Engine)
                                            v
  pilatus-projekt/.agency/config.json: { profile, tenant: "pilatus",
                                         tenant_repo: "…agency-tenant-pilatus" }
                                            ^
            agency-tenant-pilatus ──────────┘ (Overlay, privat)
```

## Warum 1 Repo PRO Mandant (nicht 1 Repo mit allen)

| | 1 Repo pro Mandant (empfohlen) | 1 Repo, alle als Ordner |
|---|---|---|
| Zugriffstrennung | Kunde sieht nur sich (NDA-sauber) | jeder sieht alle Kundendaten |
| Versionierung | eigene History pro Kunde | vermischt |
| Wartung | mehr Repos | ein Ort, aber undicht |

Brand-Guidelines + Kunden-Personas sind vertraulich -> Trennung gewinnt.
Mehrere Projekte desselben Kunden teilen sich EIN Mandanten-Repo (kein Duplizieren).

## Neuen Mandanten anlegen (Kurzfassung)

Voll: `templates/maintainer-checklists/add-new-tenant.md` bzw. `/agency new-tenant`.

1. **Template forken:** das private `agency-tenant-template`-Repo zu
   `agency-tenant-<kunde>` forken. Es bringt Ordnerstruktur, Schema und die CI
   (`validate-tenant.yml`) mit -> jedes Mandanten-Repo bleibt eigenstaendig schema-konform.
2. **Overlay fuellen:** `config.json` + `standards.md` + `design-system.md` +
   `ux.md` + `brand-voice.md` mit den Kunden-Deltas (nur was abweicht!).
3. **Im Projekt aktivieren:** `.agency/config.json` um `tenant` + `tenant_repo`
   ergaenzen, dann `update.{sh,ps1}` laufen lassen.
4. **Validieren:** `bash scripts/validate-tenant.sh <pfad-zum-overlay>` (laeuft
   auch automatisch in der CI des Mandanten-Repos).

## Reproduzierbarkeit

`tenant_pin` in `config.json` auf einen Commit-SHA setzen -> Overlay wird von
diesem SHA gezogen statt von `main` (gleiches Prinzip wie das Engine-Pinning,
siehe README "Pin auf bekannten guten Commit").

## Authentifizierung (private Mandanten-Repos)

Mandanten-Repos sind privat. `update.{sh,ps1}` zieht das Overlay deshalb ueber die
GitHub Contents-API mit Token (nicht ueber unauth. raw — das gaebe 404). Token-Quelle
in dieser Reihenfolge:

1. `AGENCY_TENANT_TOKEN` (env) — empfohlen: feingranularer, kurzlebiger PAT mit
   **nur Read-Contents** auf die `agency-tenant-*`-Repos.
2. `GITHUB_TOKEN` (env).
3. `gh auth token` (falls GitHub CLI eingeloggt).

Kein Token gefunden -> Fallback auf unauth. raw (funktioniert nur bei OEFFENTLICHEN
Repos) + Warnhinweis. Least-Privilege: gib dem Token nur Lesezugriff auf die
Mandanten-Repos, nichts weiter; kurze Lebensdauer.

## Template

Die Vorlage fuer ein neues Mandanten-Repo liegt unter
`templates/tenant-template/`. Forken/kopieren, NICHT direkt editieren — das ist
die Quelle der Wahrheit fuer das Overlay-Schema.
