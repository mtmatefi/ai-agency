# Security Policy

## Was dieses Repo macht

Dieses Repository ist eine **CLAUDE.md-Konfiguration** fuer Claude
Code / Cursor. Es enthaelt keinen ausfuehrbaren Anwendungscode, aber
zwei aktive Code-Komponenten:

1. **Update- und Setup-Scripts** (`update.ps1`, `update.sh`,
   `setup-project.ps1`, `setup-project.sh`) — werden auf Endgeraeten
   der Nutzer ausgefuehrt.
2. **GitHub Actions Workflows** — laufen auf GitHub-Infrastruktur.

## Schwachstellen melden

Wenn du eine Sicherheitsluecke findest, **bitte NICHT als oeffentliches
Issue posten**. Stattdessen:

1. GitHub Security Advisories: `Security` Tab des Repos -> `Report a vulnerability`
2. Oder direkt per E-Mail an den Maintainer

Beantwortet wird innerhalb von 7 Tagen.

## Bekanntes Threat-Modell

### T1 — Supply Chain: Repo-Kompromittierung

**Risiko:** Wenn der GitHub-Account oder `main`-Branch kompromittiert wird,
fuehren alle Nutzer beim naechsten `update.ps1`/`update.sh` veraenderten
Code aus. Das `Invoke-WebRequest | .\update.ps1`-Pattern im README ist
exakt das `curl | bash`-Antipattern.

**Mitigationen — eingebaut:**
- `.github/workflows/validate.yml` blockt strukturell kaputte Commits.
- `.github/workflows/provenance-integrity.yml` blockt Manipulation des
  `AI-PROVENANCE.md`-Audit-Trails.
- Branch-Protection auf `main` ist Pflicht — siehe `BRANCH_PROTECTION.md`.

**Mitigationen — verantwortlich der Nutzer:**
- Sicherer Install-Pfad: `git clone` + Inspektion vor Ausfuehrung
  (siehe README, Abschnitt "Sicherer Install").
- Pin auf bekannten guten Commit-SHA (in URL statt `main`).

**Bekannte Limitierung:** SHA-Manifest oder Cosign-Signing der Scripts ist
geplant aber noch nicht produktiv. Bis dahin gilt: Nutzer muessen dem
GitHub-Account vertrauen oder den sicheren Install-Pfad nehmen.

### T2 — AI-PROVENANCE-Manipulation

**Risiko:** Jemand mit Push-Rechten koennte den `AI-PROVENANCE.md`-Audit-Trail
in Zielprojekten rueckwirkend aendern. Das wuerde EU AI Act Art. 13/16
(Aufzeichnungspflichten) und CRA Anhang VII (10 Jahre Aufbewahrung) untergraben.

**Mitigationen — eingebaut im Agency-Repo selbst:**
- `.github/workflows/provenance-integrity.yml` prueft bei jedem PR ob
  `AI-PROVENANCE.md` append-only ist.

**Mitigationen — verantwortlich der Nutzer in eigenen Projekten:**
- Pre-Commit-Hook aus `templates/githooks/pre-commit` aktivieren
  (`bash scripts/install-githooks.sh` im Zielprojekt).
- Branch-Protection auch im eigenen Projekt.
- Optional: signed commits (`git commit -S`).

### T3 — Veralteter Inhalt fuehrt zu falscher Compliance-Aussage

**Risiko:** EU-Regulierungen aendern sich monatlich (Leitlinien EDPB,
Durchfuehrungsrechtsakte AI Act/CRA). Ein Projekt, das seit Monaten nicht
geupdated hat, koennte falsche Aussagen liefern.

**Mitigationen — eingebaut:**
- `RECHERCHE-PROTOKOLL` in `CLAUDE.md` zwingt jede Persona zur Live-Recherche.
- `auto-update.yml` bumpt Datums-Stempel woechtentlich (Upstream).
- Freshness-Check zur Laufzeit in `CLAUDE.md` warnt bei >30 Tagen Stand.

### T4 — Drittanbieter-GitHub-Actions kompromittiert

**Risiko:** Wenn eine in unseren Workflows verwendete Action durch
Repo-Hijacking veraendert wird (Beispiel: `tj-actions/changed-files` 2025).

**Mitigationen — eingebaut:**
- Aktuell verwendete Actions sind ausschliesslich GitHub-offizielle
  (`actions/checkout@v4`, `actions/setup-node@v4`). Diese werden von GitHub
  selbst gepflegt; Risiko gering.
- Bei Hinzufuegen von Third-Party-Actions ist SHA-Pinning Pflicht (nicht `@v1`).

## Sicherheits-Updates

- Patches werden als neue Releases mit semantischer Versionierung
  veroeffentlicht.
- Kritische Sicherheits-Patches: zusaetzlich als GitHub Security Advisory.
- Aenderungen sind im `CHANGELOG.md` unter "Sicherheit" gekennzeichnet.

## Verschlossene Annahmen

Dieses Repo erstellt keinen kryptografischen Trust-Root. Wer einen
nullvertrauens-Pfad braucht (Bundesbehoerde, Banking-Kunde), sollte:
- Eigenen Fork betreiben
- Eigene Build-Signaturen verwenden
- Updates ausschliesslich aus eigenem Mirror laden
