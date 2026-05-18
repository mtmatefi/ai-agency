# Projekt-Profile

Profile begrenzen den **Scope** der Agency fuer ein konkretes Projekt.
Nicht jedes Projekt braucht alle 14 Teams und alle EU-Regulierungen.

## Verfuegbare Profile

| Profil | Teams | Regulierungen | Wann nutzen |
|--------|-------|---------------|-------------|
| `saas-eu-b2b` | alle 14 | DSGVO, AI Act, CRA, NIS2, EAA, Data Act | Voll-SaaS fuer EU. Default. |
| `internal-tool` | 5 (Dev, Infra, Sec, UX, Data) | DSGVO | Interne Tools, Admin-Portale |
| `mobile-app-only` | 7 (kein Marketing/Sales/Legal/Finance/Graphic) | DSGVO, AI Act, EAA | Mobile-First-Produkt |
| `agency-client-work` | 11 (kein Marketing/CS) | DSGVO, AI Act, CRA, EAA | Agentur baut fuer Kunden |
| `oss-library` | 5 (Dev, Infra, Sec, Legal, Content) | CRA | OSS-Library / SDK |

## Wie waehlen

Beim `setup-project`:

```bash
# Mac/Linux
bash setup-project.sh --profile internal-tool

# Windows
.\setup-project.ps1 -Profile internal-tool
```

Ohne `--profile` Argument: Interaktive Auswahl (oder Default `saas-eu-b2b`
wenn nicht-TTY).

## Was passiert beim Auswaehlen

1. `setup-project` schreibt `.agency/config.json` ins Zielprojekt mit dem
   gewaehlten Profil + Zeitstempel.
2. `update.ps1`/`update.sh` lesen diese Config und syncen nur die Team-Files
   der erlaubten Teams (CLAUDE.md + Templates immer komplett).
3. Claude liest `.agency/config.json` beim ersten Lesen von CLAUDE.md und
   fokussiert sich automatisch auf die aktiven Teams + Regulierungen
   (siehe `CLAUDE.md` Abschnitt "PROJEKT-PROFIL").

## Eigenes Profil bauen

Lege eine neue Datei in `profiles/dein-name.json` mit dem gleichen Schema an:

```json
{
  "name": "dein-name",
  "description": "Kurzbeschreibung",
  "teams": ["development-qa", "..."],
  "regulations": ["dsgvo", "..."],
  "notes": "Optional, frei"
}
```

Gueltige Team-Namen (Dateinamen ohne `.md` aus `teams/`):
`development-qa`, `infrastructure`, `security`, `compliance`, `legal`,
`ux-ui`, `graphic-design`, `marketing-seo`, `content-editorial`,
`product-management`, `sales`, `data-analytics`, `finance`, `customer-success`

Gueltige Regulierungs-Slugs:
`dsgvo`, `ai-act`, `cra`, `nis2`, `eaa`, `dora`, `data-act`

## Profile-Wechsel zur Laufzeit

Im laufenden Projekt `.agency/config.json` editieren und neu syncen:

```bash
# Profile setzen
echo '{"profile":"mobile-app-only","teams":[...],"regulations":[...]}' > .agency/config.json

# Sync
bash update.sh
```

Bei naechstem `update` werden ueberfluessige Team-Files aus `.agency/teams/`
entfernt und fehlende nachgezogen.
