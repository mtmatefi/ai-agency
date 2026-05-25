# One Stop Agency

**14 Teams. 30+ Spezialisten. Automatisch aktiviert wenn du sie brauchst.**

Schreib deine Aufgabe — das richtige Team wird automatisch erkannt und handelt.
Kein manuelles Aktivieren. Kein Team-Management. Einfach arbeiten.

---

## Was ist das?

One Stop Agency ist eine zentrale CLAUDE.md-Konfiguration, die Claude (in Cursor, Claude Code oder Cowork) in ein vollstaendiges digitales Agentur-Team verwandelt.

Du beschreibst was du brauchst. Claude erkennt welche Teams und Personen benoetigt werden und handelt autonom bis zur definierten Freigabegrenze.

---

## Die Teams

| Team | Wer | Fuer was |
|------|-----|----------|
| Development & QA | Lucas, Sarah, Finn, Nina | Code, APIs, Tests, alle Stacks |
| Infrastructure | Kai, Lena | CI/CD, Deploy, Monitoring, Docker |
| Security | Marco, Zara | Security Reviews, Pen Testing, OWASP |
| Compliance | Elena, Thomas | ISO 27001, DSGVO, Audits |
| Legal | Claudia, Robert | Vertraege, AGB, Lizenzen |
| UX & UI | Emma, Noah | User Experience, Interface, Design Systems |
| Graphic Design | Lea, Felix | Branding, Logos, Social Media Assets |
| Marketing & SEO | Sophie, Jan | Growth, Kampagnen, SEO, Ads |
| Content & Editorial | Amelie, Ben | Copywriting, Blog, Technische Doku |
| Product Management | David, Anna | Roadmap, User Stories, Marktanalyse |
| Sales | Michael, Lisa | Pitches, CRM, Account Management |
| Data & Analytics | Julia, Tim | KPIs, Dashboards, A/B Tests |
| Finance | Sandra, Max | Budget, Pricing, Unit Economics |
| Customer Success | Petra, Lars | Onboarding, Support, Retention |

---

## Standards (eingebaut, nicht konfigurierbar — Stand 2026-05-18)

- **Security:** OWASP ASVS 5.0 Level 2 (Mai 2025) + OWASP Top 10 for LLM Applications 2025
- **Datenschutz:** ISO 27001:2022 + DSGVO (Privacy by Design, Art. 25)
- **Testing:** >= 80% Coverage, WCAG 2.1 AA (EAA-Pflicht), WCAG 2.2 AA empfohlen, Core Web Vitals green
- **Prozess:** API-First (OpenAPI 3.1 vor Code), Keep a Changelog, Definition of Done
- **Deploy:** Kein Production-Deploy ohne QA + Security + PO Sign-Off
- **Supply Chain:** SBOM (CycloneDX/SPDX) Pflicht ab 11.09.2026 (EU CRA), Sigstore/Cosign-Signing
- **EU-Regulierung:** Tracker fuer NIS2 (DE) · EU AI Act (voll ab 02.08.2026) · CRA · DORA · Data Act · EAA
- **AI-Provenance:** Pflicht-Dokumentation jeder AI-generierten Code-/Content-Aenderung
  (Datei-Header, Block-Marker, `AI-PROVENANCE.md` Log) — siehe `CLAUDE.md` Abschnitt
  "AI-CODE-DOKUMENTATIONS-PROTOKOLL"

**Recherche-Pflicht:** LLM-Wissen ist Monate veraltet. Jede Persona MUSS Standards,
CVE-Status, Framework-Versionen und Gesetzes-Stand vor Empfehlung per WebSearch
verifizieren. Siehe `CLAUDE.md` Abschnitt "RECHERCHE-PROTOKOLL".

---

## Schnellstart

### Ein-Zeilen-Install (Windows / PowerShell) — bequem, mittlere Sicherheit

In deinem Projekt-Ordner ausfuehren — laedt `update.ps1` von GitHub und startet ihn sofort:

```powershell
# Laedt alles von GitHub in dein aktuelles Projekt
Invoke-WebRequest "https://raw.githubusercontent.com/mtmatefi/ai-agency/main/update.ps1" -OutFile update.ps1; .\update.ps1
```

Danach: Projekt in Cursor / Claude Code oeffnen — `CLAUDE.md` wird automatisch geladen.

**Sicherheitshinweis:** Dieses Pattern ist `curl | bash`-aequivalent — du
vertraust meinem GitHub-Account + GitHub selbst. Fuer hoehere Sicherheit
siehe naechster Abschnitt + `SECURITY.md`.

### Ein-Zeilen-Install (Mac/Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/mtmatefi/ai-agency/main/update.sh -o update.sh && bash update.sh
```

### Sicherer Install (Inspektion vor Ausfuehrung — empfohlen fuer Production)

```bash
# 1. Repo klonen (oder eine Tag-Release herunterladen)
git clone --depth 1 https://github.com/mtmatefi/ai-agency.git /tmp/agency

# 2. Scripts und CLAUDE.md selbst durchlesen
less /tmp/agency/update.sh
less /tmp/agency/CLAUDE.md
less /tmp/agency/SECURITY.md

# 3. Wenn alles OK: Setup ausfuehren
bash /tmp/agency/setup-project.sh
```

```powershell
# Windows-Aequivalent
git clone --depth 1 https://github.com/mtmatefi/ai-agency.git C:\Temp\agency
notepad C:\Temp\agency\update.ps1
notepad C:\Temp\agency\CLAUDE.md
& C:\Temp\agency\setup-project.ps1
```

### Pin auf bekannten guten Commit (maximale Reproduzierbarkeit)

Statt `main` einen verifizierten Commit-SHA verwenden — Updates dann bewusst
durch SHA-Wechsel ausloesen, nicht automatisch:

```powershell
# Windows — Commit-SHA in URL + Parameter pinnen
$Sha = "7015f52"   # durch verifizierten Commit ersetzen
Invoke-WebRequest "https://raw.githubusercontent.com/mtmatefi/ai-agency/$Sha/update.ps1" -OutFile update.ps1
.\update.ps1 -RepoUrl "https://raw.githubusercontent.com/mtmatefi/ai-agency/$Sha"
```

```bash
# Mac/Linux
SHA="7015f52"
curl -fsSL "https://raw.githubusercontent.com/mtmatefi/ai-agency/$SHA/update.sh" -o update.sh
AGENCY_REPO_URL="https://raw.githubusercontent.com/mtmatefi/ai-agency/$SHA" bash update.sh
```

Vollstaendiges Threat-Modell + weitere Mitigationen siehe `SECURITY.md`.
Branch-Protection-Setup siehe `BRANCH_PROTECTION.md`.

### Neues Projekt einrichten (Windows, lokale Kopie)

```powershell
cd C:\Pfad\zu\deinem\Projekt
& "C:\Pfad\zu\one-stop-agency\setup-project.ps1"
```

### Neues Projekt einrichten (Mac/Linux, lokale Kopie)

```bash
cd /pfad/zu/deinem/projekt
bash /pfad/zu/one-stop-agency/setup-project.sh
```

### Auf neueste Version aktualisieren (Windows)

```powershell
cd C:\Pfad\zu\deinem\Projekt
.\update.ps1
```

### Auf neueste Version aktualisieren (Mac/Linux)

```bash
cd /pfad/zu/deinem/projekt
bash update.sh
```

---

## Wie es funktioniert

**1. CLAUDE.md wird automatisch geladen**

Claude Code und Cursor laden CLAUDE.md automatisch beim Oeffnen eines Projekts. Keine manuelle Aktivierung noetig.

**2. Automatische Team-Erkennung**

| Aufgabe enthaelt... | Aktivierte Teams |
|--------------------|-----------------|
| Code, Feature, Bug, API | Development & QA |
| Deploy, CI/CD, Server | Infrastructure |
| Security, Auth, Passwort | Security |
| DSGVO, ISO, Compliance | Compliance + Legal |
| Design, UI, Komponenten | UX & UI |
| Marketing, SEO, Kampagne | Marketing & SEO |
| Budget, Preise, Kosten | Finance |
| Onboarding, NPS, Churn | Customer Success |
| ... | ... |

**3. Autonomes Arbeiten**

Bei komplexen Aufgaben erstellt das Team einen Milestone-Plan. Du bestimmst bis zu welchem Punkt autonom gearbeitet wird, dann handelt das Team selbstaendig und liefert am Ende einen vollstaendigen Abschlussbericht.

---

## Repository-Struktur

```
one-stop-agency/
  CLAUDE.md              <- Master-Orchestrator (wird ins Projekt-Root kopiert)
  teams/
    development-qa.md    <- Team-Detail-Dokumente (werden in .agency/ gespeichert)
    infrastructure.md
    security.md
    compliance.md
    legal.md
    ux-ui.md
    graphic-design.md
    marketing-seo.md
    content-editorial.md
    product-management.md
    sales.md
    data-analytics.md
    finance.md
    customer-success.md
  .github/workflows/
    auto-update.yml      <- Woechtentliches Self-Update (Datums-Stempel + Versions-Snapshot)
  data/
    versions.snapshot.json <- Auto-generierter Versions-Snapshot (von endoflife.date)
  templates/
    AI-PROVENANCE.md     <- Append-only Log-Template (wird im Zielprojekt initialisiert)
    ai-headers-snippets.md <- Datei-Header + Block-Marker Snippets pro Sprache
    githooks/
      pre-commit         <- Client-side Hook: blockt AI-PROVENANCE.md-Modifikation
    maintainer-checklists/   <- Schritt-fuer-Schritt-Wizards (vom /agency-Skill genutzt)
      add-new-team.md
      add-new-profile.md
      add-new-regulation.md
      bump-version.md
  .claude/skills/
    agency.md            <- Maintainer-Skill (siehe oben)
  scripts/
    validate.sh          <- Repo-Integritaets-Validator (CI-getrieben)
  AI-PROVENANCE.md       <- Audit-Trail des Repos selbst (Dogfooding)
  SECURITY.md            <- Threat-Modell, Vulnerability-Reporting
  BRANCH_PROTECTION.md   <- Step-by-step main-Branch-Schutz in GitHub
  LICENSE                <- MIT
  CHANGELOG.md           <- Keep-a-Changelog
  update.ps1             <- Update-Script Windows
  update.sh              <- Update-Script Mac/Linux
  setup-project.ps1      <- Einmal-Setup Windows
  setup-project.sh       <- Einmal-Setup Mac/Linux
  README.md              <- Diese Datei
```

Im Projekt nach dem Setup:

```
dein-projekt/
  CLAUDE.md              <- Automatisch geladen von Claude
  AI-PROVENANCE.md       <- Append-only Audit-Log (NICHT in .gitignore — Teil der Doku!)
  .agency/               <- Wird von .gitignore ausgeschlossen
    CLAUDE.md            <- Backup
    teams/               <- Alle Team-Dateien
    templates/           <- AI-Provenance-Template + Snippets pro Sprache
  ...                    <- Dein eigentlicher Projekt-Code
```

---

## Maintainer-Skill `/agency` — wenn du dieses Repo selbst editierst

Wenn du in `mtmatefi/ai-agency` arbeitest und Aenderungen am Setup vornimmst,
nutzt Claude automatisch den **Maintainer-Modus** (definiert in `CLAUDE.md`):
Validator wird vor jedem Commit-Vorschlag durchlaufen, CHANGELOG +
AI-PROVENANCE gepflegt, Sign-Off-Matrix konsistent gehalten.

Aktive Wartung passiert ueber den `/agency`-Skill (`.claude/skills/agency.md`):

| Subkommando | Was es macht |
|-------------|--------------|
| `/agency` | Status + Menue |
| `/agency check` | Schneller Validator-Run + Repo-Status |
| `/agency audit` | Tiefe Konsistenz-Pruefung (Personas, Sign-Offs, Profile, Standards-Aktualitaet via Webrecherche, CHANGELOG-vs-Git-Drift, Branch-Protection) |
| `/agency optimize` | Kontinuierliche Verbesserung — Webrecherche zu neuen EU-Regulierungen, neuen Framework-Releases, OWASP-Updates, Persona-Tiefen-Vorschlaege. Output: priorisierte Liste P0/P1/P2. |
| `/agency new-team` | Guided Wizard: neues Team hinzufuegen (folgt `templates/maintainer-checklists/add-new-team.md`) |
| `/agency new-profile` | Guided Wizard: neues Profil |
| `/agency new-regulation` | Guided Wizard: neue EU-/internationale Regulierung integrieren (web-research-intensiv) |
| `/agency bump <m\|n\|p>` | Versions-Bump inkl. CHANGELOG + Tag-Vorschlag |
| `/agency log "<task>"` | Sauber formatierten AI-PROVENANCE-Eintrag anfuegen |

Globale Pflichten (gelten in jedem Subkommando):
1. Recherche-Pflicht (WebSearch vor jeder datierten Aussage)
2. AI-Provenance fuer alles was Claude generiert
3. Validator gruen vor jedem Commit-Vorschlag
4. Append-only fuer CHANGELOG + AI-PROVENANCE
5. Co-Authored-By: Claude in jedem Commit-Vorschlag

Die Checklisten in `templates/maintainer-checklists/` sind die Quelle der
Wahrheit fuer Schritt-fuer-Schritt-Operationen. Wenn die Checkliste sich
aendert, aendert sich das Verhalten — kein Doppel-Dokumentieren in der
Skill-Datei.

---

## Projekt-Profile — nicht jedes Projekt braucht alle 14 Teams

Beim `setup-project` wird ein Profil gewaehlt (Default `saas-eu-b2b`).
Es bestimmt welche Teams aktiv sind und welche EU-Regulierungen Pflicht-Check sind:

| Profil | Teams | Regulierungen | Use-Case |
|--------|-------|---------------|----------|
| `saas-eu-b2b` | alle 14 | DSGVO, AI Act, CRA, NIS2, EAA, Data Act | Voll-SaaS, EU-B2B-Markt |
| `internal-tool` | 5 | DSGVO | Interne Tools, Admin-Portale |
| `mobile-app-only` | 7 | DSGVO, AI Act, EAA | Mobile-App-Projekt |
| `agency-client-work` | 11 | DSGVO, AI Act, CRA, EAA | Agentur fuer wechselnde Kunden |
| `oss-library` | 5 | CRA | OSS-Library / SDK |

**Verwendung:**
```bash
# Beim Setup (interaktive Auswahl oder via Flag)
bash setup-project.sh --profile internal-tool

# Windows
.\setup-project.ps1 -Profile internal-tool
```

Schreibt `.agency/config.json` ins Projekt. Bei jedem `update.{ps1,sh}`
werden nur die Team-Files der aktiven Teams gesynct (ueberfluessige
Files werden automatisch entfernt).

**Profil-Wechsel zur Laufzeit:** `.agency/config.json` editieren und
`update.ps1`/`update.sh` ausfuehren.

**Eigene Profile:** in `profiles/dein-name.json` mit gleichem Schema — siehe
`profiles/README.md`.

---

## AI-Provenance — Pflicht-Dokumentation aller AI-generierten Aenderungen

Damit fuer jedes Stueck Code/Content jederzeit klar ist **was AI gemacht hat und was
es macht**, gilt im Projekt die Pflicht laut `CLAUDE.md` -> "AI-CODE-DOKUMENTATIONS-PROTOKOLL":

**Ebene A — Datei-Header** (bei NEUEN Dateien mit substantieller AI-Generierung):

```typescript
/**
 * <1-Satz-Zweck der Datei>
 *
 * @ai-assisted: claude-opus-4-7 via One-Stop-Agency / <Persona>
 * @ai-date: 2026-05-18
 * @ai-task: <kurze Beschreibung>
 * @human-review: <Name oder OFFEN>, <Datum oder OFFEN>
 */
```

**Ebene B — Block-Marker** (bei AI-Sektionen innerhalb existierender Dateien):

```
// @ai-block:start (claude-opus-4-7 / <Persona>, 2026-05-18)
// purpose: <was tut der Block>
... AI-generierter Code ...
// @ai-block:end
```

**Ebene C — `AI-PROVENANCE.md`** (Append-only Log im Projekt-Root):

Wird beim `setup-project`/`update`-Lauf automatisch im Projekt-Root angelegt, falls noch nicht vorhanden.
Pro Session/PR wird ein neuer Eintrag angefuegt mit Files, Model, Persona, Reviewer, Task, Notes.

**Ebene D — Commit/PR**: `Co-Authored-By: Claude...` + PR-Abschnitt "AI Assistance"
(was AI-generiert vs. Mensch-geschrieben, Reviewer).

**Snippets pro Sprache:** `templates/ai-headers-snippets.md` (in `.agency/templates/` nach Setup)
mit Vorlagen fuer TS/JS, PHP, Kotlin, Python, YAML, JSON, SQL, Markdown, Shell.

Wer prueft was: Dev-Team setzt Marker, QA (Nina) blockt Release ohne Marker,
Security (Marco) reviewt AI-generierten Security-Code extra-skeptisch, Legal (Robert)
prueft IP-/Lizenz-Implikationen, Content (Ben) pflegt das Log.

**Regulatorischer Hintergrund:** Diese Doku stuetzt EU AI Act (Art. 13, 16, 50),
CRA (technische Doku, 10 Jahre Aufbewahrung) und ISO 27001:2022 Asset-Management.

---

## Selbst-Update — Drei Ebenen

Dieses Repo bleibt **automatisch aktuell** auf drei Ebenen:

### Ebene 1 — Upstream (GitHub Actions, woechtentlich)

`.github/workflows/auto-update.yml` laeuft jeden Montag 06:00 UTC und:
- Aktualisiert den `Stand: YYYY-MM-DD`-Datumsstempel in `CLAUDE.md` + `README.md`
- Holt aktuelle Framework-EOL-Versionen von endoflife.date in `data/versions.snapshot.json`
- Committet automatisch wenn etwas geaendert wurde

Manuell triggerbar via `Actions -> Auto-Update Agency -> Run workflow` in GitHub.

### Ebene 2 — Downstream (in deinem Projekt)

In jedem Projekt das die Agency nutzt: Scheduled Task / Cron, der `update.ps1`/`update.sh`
einmal pro Tag ausfuehrt. So sind alle Projekte spaetestens 24h nach einem Push aktuell.

**Windows Task Scheduler (taeglich 09:00):**
```powershell
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File C:\Pfad\zu\Projekt\update.ps1"
$Trigger = New-ScheduledTaskTrigger -Daily -At 9am
Register-ScheduledTask -TaskName "Agency Update" -Action $Action -Trigger $Trigger
```

**Mac/Linux Cron (`crontab -e`):**
```
0 9 * * * cd /pfad/zu/projekt && bash update.sh >> /tmp/agency-update.log 2>&1
```

### Ebene 3 — Live-Recherche durch jede Persona

Wichtigste Ebene: Jede Persona ist verpflichtet, vor jeder fachlichen Aussage
(CVE-Status, Standard-Version, Framework-Version, Gesetzes-Stand) eine
Web-Recherche durchzufuehren — siehe `CLAUDE.md` Abschnitt
"RECHERCHE-PROTOKOLL". Das stellt sicher, dass auch zwischen Auto-Updates
nichts Veraltetes empfohlen wird.

### Was tun wenn du selbst etwas aenderst?

1. Aendere die Datei in diesem Repository
2. Commit + push -> GitHub Action verteilt nichts neues, aber der Datums-Bump
   passiert am naechsten Montag automatisch
3. In jedem Projekt: `update.ps1` oder `bash update.sh` ausfuehren (oder warten bis Scheduler laeuft)

---

## Eigenen Fork verwenden (optional)

Die Standard-URL in den Scripts zeigt auf `mtmatefi/ai-agency`. Wenn du einen eigenen Fork betreibst, ueberschreibe sie per Parameter / Umgebungsvariable — Scripts selbst musst du nicht editieren:

```powershell
# Windows
.\update.ps1 -RepoUrl "https://raw.githubusercontent.com/DEIN-USERNAME/DEIN-REPO/main"
```

```powershell
# Windows: dauerhaft als Umgebungsvariable
[Environment]::SetEnvironmentVariable("AGENCY_REPO_URL", "https://raw.githubusercontent.com/DEIN-USERNAME/DEIN-REPO/main", "User")
```

```bash
# Mac/Linux: einmalig
AGENCY_REPO_URL="https://raw.githubusercontent.com/DEIN-USERNAME/DEIN-REPO/main" bash update.sh

# Mac/Linux: dauerhaft (in ~/.zshrc oder ~/.bashrc)
export AGENCY_REPO_URL="https://raw.githubusercontent.com/DEIN-USERNAME/DEIN-REPO/main"
```

---

## GitHub Repository erstellen

```bash
# 1. GitHub Repo erstellen (Private empfohlen — enthaelt deine Workflows!)
#    github.com -> New Repository -> "one-stop-agency" -> Private -> Create

# 2. Lokal initialisieren
cd outputs/one-stop-agency
git init
git add .
git commit -m "feat: initial one stop agency setup"
git branch -M main

# 3. Mit GitHub verbinden und pushen
git remote add origin https://github.com/mtmatefi/ai-agency.git
git push -u origin main
```

---

Version: 1.1 | Stand: 2026-05-25 (Selbst-Update woechtentlich, siehe oben)
Stack: React 19 / TS 5.x / Next.js 16 | PHP 8.4 / Laravel 13 | Kotlin 2.1 / Compose 2026.04 | Supabase / Postgres 17
Standards: OWASP ASVS 5.0 L2 | OWASP LLM Top 10 (2025) | ISO 27001:2022 | DSGVO | WCAG 2.1/2.2 AA | EAA
EU-Regulierung: NIS2 (DE 06.12.2025) · AI Act (voll 02.08.2026) · CRA (Reporting 11.09.2026) · DORA · Data Act
