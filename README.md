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

## Standards (eingebaut, nicht konfigurierbar)

- **Security:** OWASP ASVS Level 2
- **Datenschutz:** ISO 27001 + DSGVO (Privacy by Design, Art. 25)
- **Testing:** >= 80% Coverage, WCAG 2.1 AA, Core Web Vitals green
- **Prozess:** API-First (OpenAPI vor Code), Keep a Changelog, Definition of Done
- **Deploy:** Kein Production-Deploy ohne QA + Security + PO Sign-Off

---

## Schnellstart

### Ein-Zeilen-Install (Windows / PowerShell) — empfohlen

In deinem Projekt-Ordner ausfuehren — laedt `update.ps1` von GitHub und startet ihn sofort:

```powershell
# Laedt alles von GitHub in dein aktuelles Projekt
Invoke-WebRequest "https://raw.githubusercontent.com/mtmatefi/ai-agency/main/update.ps1" -OutFile update.ps1; .\update.ps1
```

Danach: Projekt in Cursor / Claude Code oeffnen — `CLAUDE.md` wird automatisch geladen.

### Ein-Zeilen-Install (Mac/Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/mtmatefi/ai-agency/main/update.sh -o update.sh && bash update.sh
```

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
  .agency/               <- Wird von .gitignore ausgeschlossen
    CLAUDE.md            <- Backup
    teams/               <- Alle Team-Dateien
  ...                    <- Dein eigentlicher Projekt-Code
```

---

## Zentrale Pflege

Dieses Repository ist der **Single Source of Truth** fuer alle Projekte.

**Wenn du etwas aenderst** (neues Team, neue Richtlinie, aktualisierter Standard):
1. Aendere es in diesem Repository
2. Committe und pushe nach GitHub
3. In jedem Projekt: `update.ps1` oder `bash update.sh` ausfuehren
4. Die Aenderung ist sofort aktiv

**Automatische Updates** (optional):
- Windows Task Scheduler: `update.ps1` taeglich um 9 Uhr
- Mac/Linux Cron: `0 9 * * * cd /pfad/projekt && bash update.sh`

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

Version: 1.0 | Mai 2026
Stack: React/TS/Next.js | PHP/Laravel | Android/Kotlin | Supabase
Standards: OWASP ASVS L2 | ISO 27001 | DSGVO | WCAG 2.1 AA
