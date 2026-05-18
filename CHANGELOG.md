# Changelog

Alle wesentlichen Aenderungen an diesem Projekt sind in dieser Datei dokumentiert.

Format: [Keep a Changelog](https://keepachangelog.com/de/1.1.0/).
Versionierung: [Semantische Versionierung](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.8.0] - 2026-05-18

### Hinzugefuegt — Maintainer-Skill `/agency`
- **.claude/skills/agency.md** — Skill fuer das Editieren des Agency-Repos
  selbst. Subkommandos `check`, `audit`, `optimize`, `new-team`,
  `new-profile`, `new-regulation`, `bump`, `log`.
- **templates/maintainer-checklists/** — Schritt-fuer-Schritt-Wizards:
  - `add-new-team.md` (12 Schritte inkl. Routing, Sign-Off, Profile, Validator)
  - `add-new-profile.md`
  - `add-new-regulation.md` (web-research-intensiv)
  - `bump-version.md`
- **CLAUDE.md neue Sektion MAINTAINER-MODUS** — automatisch aktiv bei
  Aenderungen am Agency-Repo selbst (Marker-Detection). Erzwingt Validator
  + CHANGELOG + AI-PROVENANCE + Sign-Off-Matrix-Konsistenz bei jedem
  Commit-Vorschlag.
- **scripts/validate.sh:** zusaetzlicher Check fuer `.claude/skills/agency.md`
  und die 4 Maintainer-Checklisten.

### Geaendert
- README: neue Sektion "Maintainer-Skill /agency" mit Subkommando-Tabelle.
- README: Repo-Struktur um `.claude/skills/` + `templates/maintainer-checklists/`.

## [1.7.0] - 2026-05-18

### Hinzugefuegt — Projekt-Profile (Slim-Mode-Setup)
- **profiles/** Verzeichnis mit 5 vordefinierten Profilen + eigenem README:
  - `saas-eu-b2b` — alle 14 Teams + alle EU-Regulierungen (Default)
  - `internal-tool` — 5 Teams + DSGVO
  - `mobile-app-only` — 7 Teams + DSGVO/AI Act/EAA
  - `agency-client-work` — 11 Teams (ohne Marketing/CS) + 4 EU-Regulierungen
  - `oss-library` — 5 Teams + CRA
- **setup-project.ps1/.sh:** Neue Option `-Profile`/`--profile`.
  Interaktive Auswahl wenn nicht gegeben + TTY. Schreibt `.agency/config.json`
  ins Zielprojekt.
- **update.ps1/.sh:** Lesen `.agency/config.json`. Filtern Team-Files nach Profil
  (CLAUDE.md + Templates immer komplett). Entfernen ueberfluessige Team-Files
  bei Profil-Wechsel.
- **CLAUDE.md:** Neuer Abschnitt "PROJEKT-PROFIL" — Anweisung an Claude,
  `.agency/config.json` zu lesen und deaktivierte Teams nicht stillschweigend
  zu uebergehen, sondern auf Profil hinzuweisen.
- **scripts/validate.sh:** Erweitert um Profile-Check + workflow-Check
  (provenance-integrity.yml jetzt Pflicht).

## [1.6.0] - 2026-05-18

### Hinzugefuegt — Supply Chain + AI-Provenance Integritaet
- **SECURITY.md** — Threat-Modell (T1 Supply Chain, T2 AI-Provenance-Manipulation,
  T3 Veralteter Inhalt, T4 Drittanbieter-Actions), Reporting-Pfad.
- **BRANCH_PROTECTION.md** — Step-by-step Setup fuer GitHub Branch-Protection
  (UI-Variante + `gh` CLI). Inkl. Pre-Commit-Hook Aktivierung im Zielprojekt
  (manueller 4-Zeilen-Setup, kein Auto-Installer).
- **AI-PROVENANCE.md im Repo selbst** — Dogfooding des Provenance-Protokolls
  fuer das Agency-Repo. Backfill von v1.0 bis v1.6.
- **.github/workflows/provenance-integrity.yml** — server-side Enforcement
  dass AI-PROVENANCE.md append-only ist. Blockt PRs die alte Eintraege aendern.
- **templates/githooks/pre-commit** — client-side Pre-Commit-Hook fuer
  Zielprojekte (verhindert lokal die Modifikation alter Eintraege).
- **README.md:** neuer "Sicherer Install"-Abschnitt (git clone + inspect) und
  "Pin auf Commit-SHA"-Variante (max. Reproduzierbarkeit). Sicherheits-Hinweis
  beim One-Liner-Install.

### Sicherheit
- Transparente Offenlegung des `curl | bash`-Patterns im One-Liner-Install
  (vorher implizit, jetzt explizit als Risiko + Mitigationen dokumentiert).

## [1.5.0] - 2026-05-18

### Hinzugefuegt
- **LICENSE** (MIT) — vorher fehlte komplett. Rechtssicherheit fuer Nutzer/Forks.
- **CHANGELOG.md** (diese Datei) — Ben (Tech Writer) predigt Keep-a-Changelog,
  jetzt halten wir uns selbst dran.
- **scripts/validate.sh** — Repo-Integritaets-Validator (Top-Level-Dateien,
  14 Team-Files, Templates, Sync-Konsistenz update.ps1/sh <-> teams/templates,
  Platzhalter-Check, Markdown-Header).
- **.github/workflows/validate.yml** — laeuft Validator bei jedem Push + PR.
- **.gitignore** — IDE-, OS-, Temp-Dateien. `data/versions.snapshot.json`
  bleibt explizit getrackt (Audit-Trail).

## [1.4.0] - 2026-05-18 (Commit ed5b3c6)

### Geaendert — RACI / Koordination
- **Sign-Off-Matrix:** PO (David) in alle produktrelevanten Freigaben ergaenzt
  (vorher fehlte bei Barrierefreie-App, EU-Release, Finanz-ICT).
- **Stellvertreter-Spalte** zur Sign-Off-Matrix hinzugefuegt — Marco/Zara,
  Elena/Thomas, Claudia/Robert, David/Anna, Sarah/Lucas, Kai/Lena, Sandra/Max,
  Sophie/Jan, Emma/Noah. Eliminiert Single-Point-of-Failure.
- **Neue Sign-Off-Zeile** "AI-generierter Code in Production" — Nina blockt
  Releases ohne Header/Block-Marker + AI-PROVENANCE-Eintrag.
- **Neue Sign-Off-Zeile** "Daten-/Sicherheitsvorfall (DSGVO Art. 33 / NIS2 / CRA)".
- **"falls Datenbezug"-Schlupfloch entfernt:** "Neue API live" jetzt zweigeteilt
  (Default: mit PII, requires Elena+David; selten: rein technisch, nur Sarah+Marco).
- **ZUSAMMENARBEIT & ESKALATION** neu strukturiert in drei Gruppen: klassisch,
  regulierungsgetrieben (CRA, AI Act, NIS2, DSGVO Art. 33, EAA, DORA),
  AI-Provenance-getrieben.

## [1.3.0] - 2026-05-18 (Commit 21afd73)

### Hinzugefuegt — AI-Code-Dokumentations-Protokoll
- **Pflicht-Protokoll** in CLAUDE.md: jeder AI-generierte Code/Content MUSS
  dokumentiert sein. Vier Ebenen: Datei-Header (A), Block-Marker (B),
  Projekt-Log `AI-PROVENANCE.md` (C), Commit-Message (D).
- **templates/AI-PROVENANCE.md** — Append-only Audit-Log-Template, wird durch
  setup-project ins Zielprojekt-Root initialisiert (nie ueberschrieben).
- **templates/ai-headers-snippets.md** — Header/Block-Marker-Snippets fuer
  TS/JS, PHP, Kotlin/Java, Python, YAML/JSON/SQL, Markdown, Shell/PS.
- **Persona-Pflichten:** Lucas/Sarah/Finn setzen Marker, Nina blockt ohne,
  Marco extra-skeptisch bei AI-generiertem Auth/Crypto-Code, Robert prueft
  IP/Lizenz-Implikationen, Ben pflegt das Log.
- **Regulatorischer Bezug:** EU AI Act Art. 13/16/50, CRA Anhang VII
  (10-Jahres-Aufbewahrung), ISO 27001:2022 Asset Management.

### Geaendert
- update.ps1/.sh: synchronisieren templates/ mit nach `.agency/templates/`.
- setup-project.ps1/.sh: initialisieren AI-PROVENANCE.md im Projekt-Root.

## [1.2.0] - 2026-05-18 (Commit a087852)

### Geaendert — Standards-Refresh auf Mai 2026
- **OWASP ASVS 4.0.3 -> 5.0** (Mai-2025-Release).
- **ISO 27001:2013 -> :2022** (2013-Version seit 31.10.2025 abgelaufen).
- **OWASP Top 10 for LLM Applications 2025** komplett dokumentiert.
- **Passwort-Hashing:** Argon2id als OWASP-Default (min 19 MiB / t=2 / p=1);
  bcrypt als Fallback. TLS 1.3 explizit, AES-GCM / ChaCha20-Poly1305.
- **WCAG 2.1 AA** weiter EAA-Pflicht-Bar, **2.2 AA empfohlen**.
- **Tech-Stack:** React 19.2.x, Next.js 16.2, Laravel 13, PHP 8.4,
  Kotlin 2.1, Compose BOM 2026.04.01, Compose Multiplatform 1.10 prod-ready,
  Node.js 22 LTS, PostgreSQL 17.

### Hinzugefuegt — EU-Regulierungs-Coverage
- **EU AI Act:** voll anwendbar + Sanktionen ab 02.08.2026; GPAI seit 02.08.2025.
- **Cyber Resilience Act (CRA):** Reporting ab 11.09.2026, voll ab 11.12.2027,
  SBOM Pflicht.
- **NIS2 Deutschland (NIS2UmsuCG):** in Kraft 06.12.2025, BSI-Registrierung
  Frist 04.2026.
- **European Accessibility Act (EAA):** durchsetzbar seit 28.06.2025.
- **DORA:** anwendbar seit 17.01.2025 (Finanzsektor).
- **EU Data Act:** in Kraft seit 12.09.2025.

### Hinzugefuegt — Recherche- und Update-Protokolle
- **RECHERCHE-PROTOKOLL** in CLAUDE.md: jede Persona MUSS WebSearch nutzen
  vor jeder datierten Aussage (CVE, Versionsstand, Gesetzes-Stand,
  Standard-Version). Pflicht-Quellen-Tabelle pro Domaene.
- **.github/workflows/auto-update.yml** — woechtentliches Selbst-Update
  (Datums-Stempel + Versions-Snapshot von endoflife.date).
- **SELBST-UPDATE-PROTOKOLL** dokumentiert (Upstream + Downstream + Runtime).

### Geaendert — Supply Chain
- GitHub Actions: SHA-Pinning, OIDC fuer Cloud-Auth.
- SBOM-Generierung (Syft/CycloneDX), Sigstore/Cosign-Signing, SLSA L3.
- OSV-Scanner, Trivy, Grype als Standard.

## [1.1.0] - 2026-05-18 (Commit 1030478)

### Hinzugefuegt
- **One-Liner-Install** (Windows + Mac/Linux) im README — laedt update-Script
  direkt von GitHub und startet es.

### Geaendert
- update.ps1 / update.sh: Platzhalter `DEIN-USERNAME/DEIN-REPO` in
  Fehlerhinweis-Texten ersetzt durch `mtmatefi/ai-agency`.
- README: obsoleter "Konfiguration"-Abschnitt durch knappen "Eigenen Fork
  verwenden"-Block ersetzt.

## [1.0.0] - 2026-05-18 (Commit 51ce97d)

### Hinzugefuegt
- **Initial Release**: 14 Teams, 30+ Personas, zentrales CLAUDE.md.
- **Teams:** Development & QA, Infrastructure, Security, Compliance, Legal,
  UX & UI, Graphic Design, Marketing & SEO, Content & Editorial,
  Product Management, Sales, Data & Analytics, Finance, Customer Success.
- **Standards:** OWASP ASVS L2, ISO 27001, DSGVO, WCAG 2.1 AA, Core Web Vitals.
- **Scripts:** setup-project.ps1/.sh, update.ps1/.sh.
- **Routing-Tabelle, AGENCY-ANALYSE-Format, Sign-Off-Matrix** in CLAUDE.md.
