# Checkliste: Neues Team hinzufuegen

Wizard fuer `/agency new-team`. Schritt-fuer-Schritt — KEINEN Schritt
ueberspringen, sonst wird das Repo inkonsistent.

## Inputs vom User einholen

```
Team-Slug (kebab-case, z.B. "ai-engineering"): ___
Team-Anzeigename (z.B. "AI Engineering"): ___
Zweck (1-2 Saetze): ___
Routing-Keywords (Komma-getrennt): ___
Personen (Name, Rolle, Stack): mind. 1, max. 4
  - Person 1: ___ | ___ | ___
  - Person 2: ___ | ___ | ___
Sign-Off-Beteiligung (wo ist diese Persona Pflicht-Reviewer? — kann leer sein): ___
Stellvertreter-Empfehlung (wer aus anderem Team kann einspringen): ___
```

## Schritt 1 — Slug + Existenz pruefen

```bash
# Slug pruefen: kebab-case, kein Konflikt
SLUG="<team-slug>"
[[ "$SLUG" =~ ^[a-z]+(-[a-z]+)*$ ]] || ERROR "ungueltiger Slug"
[ -f "teams/$SLUG.md" ] && ERROR "Team existiert bereits"
```

## Schritt 2 — Team-Detail-File anlegen

Erstelle `teams/<slug>.md` nach folgender Vorlage. WICHTIG:
- Datei-Header laut CLAUDE.md AI-CODE-DOKUMENTATIONS-PROTOKOLL (Ebene A)
- Recherche-Pflicht-Hinweis im Header
- Mindest-Inhalt: Zweck, Personas mit Profil-Block, Standards/Pflicht-Checks

Vorlage (kuerzen falls weniger Personen):

```markdown
# TEAM: <ANZEIGENAME IN GROSSBUCHSTABEN>
# One Stop Agency — Deep Expertise Document

Fuer: <Zweck-Beschreibung>
Stack: <Tools, Frameworks, Plattformen>
RECHERCHE-PFLICHT: <Domain-spezifisch — welche offiziellen Quellen vor
jeder fachlichen Aussage zu pruefen sind>

---

## <NACHNAME, VORNAME IN GROSSBUCHSTABEN> — <ROLLE>

**Profil:** <Alter> Jahre, <Erfahrung> Jahre Erfahrung | <Ort>
**Stack:** <Tools detailliert>
**Persoenlichkeit:** <1-2 Saetze Profil>
**Signatur:** "<charakteristisches Zitat>"
**Kommunikation:** <Stil>
**Recherche-Pflicht:** <welche Quellen diese Persona vor jeder Aussage konsultiert>

### Staerken im Detail

**<Bereich 1>**
- <konkrete Methode/Best-Practice>
- <konkrete Methode/Best-Practice>

**<Bereich 2>**
...

### Entscheidungsregeln

| Situation | Entscheidung |
|-----------|-------------|
| <fall> | <was diese Persona macht> |

---

## TEAM-STANDARDS

<Standards die ALLE Personen des Teams einhalten>
```

## Schritt 3 — CLAUDE.md ergaenzen (3 Stellen)

### 3a) TEAM-ROUTING-Tabelle

```
| Wenn die Anfrage enthaelt... | Aktive Teams |
|------------------------------|--------------|
...
| <Keywords> | <Team-Anzeigename> |   <- NEUE ZEILE
```

### 3b) DIE TEAMS & PERSONEN — Voll-Block

```
### <ANZEIGENAME IN GROSSBUCHSTABEN>
Fuer: <Zweck>

**<Persona Name>** - <Rolle>
<Alter> Jahre, <Erfahrung> Jahre Erfahrung. <1-Satz-Profil>.
"<Signatur>"
Staerken: <komma-getrennt>

Standards: <Pflicht-Checks dieses Teams>

---
```

### 3c) Sign-Off-Matrix (falls relevant)

```
| <neuer Zeile mit "Wer muss abnicken" + "Stellvertreter"> |
```

### 3d) ZUSAMMENARBEIT & ESKALATION (falls relevant)

```
- <neue typische Aktivitaet> -> <Lead-Persona> + <Co-Personas>
```

### 3e) TIEFERGEHENDE TEAM-DOKUMENTE — Liste am Ende

```
- teams/<slug>.md   <- NEU
```

## Schritt 4 — update.ps1 + update.sh: File-Liste ergaenzen

In beiden Scripts die `FilesToSync` / `FILES` Liste erweitern um:
```
"teams/<slug>.md"
```

## Schritt 5 — scripts/validate.sh: EXPECTED_TEAMS Liste ergaenzen

```bash
EXPECTED_TEAMS=(
    ...
    "<slug>"   # NEU
)
```

## Schritt 6 — profiles/*.json updaten (Entscheidung pro Profil)

Fuer jedes der 5 Standard-Profile entscheiden: nehmen wir das neue Team mit auf?

- `saas-eu-b2b.json` — meist ja (Voll-Set)
- `internal-tool.json` — meist nein (slim)
- `mobile-app-only.json` — nur wenn Team mobile-relevant
- `agency-client-work.json` — meist ja (Agentur-Voll-Set ohne Marketing)
- `oss-library.json` — nur wenn OSS-relevant

## Schritt 7 — Validator durchlaufen

```bash
bash scripts/validate.sh
# Muss gruen sein.
```

## Schritt 8 — Tests (manuell)

- Simuliere setup-project mit jedem Profil das das Team enthaelt:
  ```bash
  TMPDIR=$(mktemp -d)
  cd $TMPDIR
  bash <agency>/setup-project.sh --profile saas-eu-b2b <agency>
  ls .agency/teams/<slug>.md  # muss da sein
  ```

## Schritt 9 — CHANGELOG.md aktualisieren

Eintrag im naechsten Version-Block (oder neuer `## [Unreleased]`):

```
### Hinzugefuegt
- **Neues Team**: <Anzeigename> (Slug: `<slug>`)
  - Personen: <Liste>
  - Routing-Keywords: <Keywords>
  - In Profilen aktiviert: <welche>
```

## Schritt 10 — AI-PROVENANCE.md Eintrag

Anfuegen UEBER `<!-- AI-PROVENANCE-LOG-END -->`:

```
## YYYY-MM-DD — feat(team): <slug> hinzugefuegt

Files:
  - teams/<slug>.md           (NEW, AI-generated)
  - CLAUDE.md                 (MODIFIED, ai-block — TEAM-ROUTING + Vollblock + Sign-Off)
  - update.ps1                (MODIFIED, +teams/<slug>.md in FilesToSync)
  - update.sh                 (MODIFIED, +teams/<slug>.md in FILES)
  - scripts/validate.sh       (MODIFIED, +<slug> in EXPECTED_TEAMS)
  - profiles/*.json           (MODIFIED, ja-nein-Entscheidungen)
  - CHANGELOG.md              (MODIFIED, +Eintrag)

Model:    claude-opus-4-8 (1M context)
Persona:  Agency Director (Cross-Team Setup)
Reviewer: OFFEN
Task:     Team "<Anzeigename>" hinzufuegen
Notes:    <Begruendung + Use-Case + warum jetzt>
Commit:   (dieser Commit)
```

## Schritt 11 — Commit-Message-Vorschlag

```
feat(team): add <Anzeigename> team (<slug>)

Adds a new specialist team to the agency: <Anzeigename>. Covers
<Zweck-Kurz>.

Files:
- teams/<slug>.md — full team document with <N> personas
- CLAUDE.md — routing, team summary, sign-off matrix update
- update.{ps1,sh} — file sync list
- scripts/validate.sh — expected-teams list
- profiles/*.json — profile inclusion decisions
- CHANGELOG.md, AI-PROVENANCE.md

Sign-offs pending (laut Sign-Off-Matrix):
- [ ] mtmatefi (Repo-Eigner)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>
```

## Schritt 12 — Push

Nicht ohne explizite Bestaetigung des Users. Sollte `git push` erst nach
User-OK gemacht werden.
