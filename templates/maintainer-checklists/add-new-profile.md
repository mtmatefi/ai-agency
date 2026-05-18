# Checkliste: Neues Profil hinzufuegen

Wizard fuer `/agency new-profile`.

## Inputs

```
Profil-Slug (kebab-case, z.B. "fintech-saas"): ___
Profil-Description (1-2 Saetze): ___
Aktive Teams (Liste aus 14 moeglichen): ___
Aktive Regulierungen (aus dsgvo|ai-act|cra|nis2|eaa|dora|data-act): ___
Notes (optional, Use-Case-Hinweis): ___
```

## Schritt 1 — Slug pruefen

```bash
SLUG="<profil-slug>"
[[ "$SLUG" =~ ^[a-z]+(-[a-z]+)*$ ]] || ERROR "ungueltiger Slug"
[ -f "profiles/$SLUG.json" ] && ERROR "Profil existiert bereits"
```

## Schritt 2 — JSON-File anlegen

`profiles/<slug>.json`:

```json
{
  "name": "<slug>",
  "description": "<beschreibung>",
  "teams": [
    "<team-slug-1>",
    "<team-slug-2>"
  ],
  "regulations": ["dsgvo", "..."],
  "notes": "<wann/wofuer nutzen>"
}
```

WICHTIG: Slugs in `teams` MUESSEN existieren — gegen `EXPECTED_TEAMS` in
`scripts/validate.sh` validieren.

## Schritt 3 — JSON-Syntax validieren

```bash
jq empty "profiles/<slug>.json" || ERROR "ungueltiges JSON"
```

## Schritt 4 — setup-project.{ps1,sh} pruefen

Pruefe ob `KNOWN_PROFILES` Array das neue Profil enthaelt — wenn nicht, erweitern.
(Custom-Profile sind theoretisch auch ohne KNOWN_PROFILES-Eintrag nutzbar via
direktem `--profile`-Flag, aber fuer interaktive Auswahl muss es dort stehen.)

```bash
# setup-project.sh
KNOWN_PROFILES=("saas-eu-b2b" "internal-tool" "mobile-app-only" "agency-client-work" "oss-library" "<slug>")

# setup-project.ps1
$KnownProfiles = @("saas-eu-b2b","internal-tool","mobile-app-only","agency-client-work","oss-library","<slug>")
```

## Schritt 5 — profiles/README.md updaten

Tabelle erweitern + Anwendungsfall ergaenzen.

## Schritt 6 — README.md updaten

Top-Level Profile-Tabelle erweitern.

## Schritt 7 — Validator durchlaufen

```bash
bash scripts/validate.sh
```

Muss gruen sein. Der Validator prueft `profiles/*.json`-Syntax (wenn jq da).

## Schritt 8 — Test

```bash
TMPDIR=$(mktemp -d)
cd $TMPDIR
git init -q
bash <agency>/setup-project.sh --profile <slug> <agency>
cat .agency/config.json | jq .
# muss das Profil enthalten
```

## Schritt 9 — CHANGELOG + AI-PROVENANCE + Commit (analog zu add-new-team)
