# Changelog

Alle wesentlichen Aenderungen an diesem Projekt sind in dieser Datei dokumentiert.

Format: [Keep a Changelog](https://keepachangelog.com/de/1.1.0/).
Versionierung: [Semantische Versionierung](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.12.0] - 2026-06-23

### Hinzugefuegt — Konsolidiertes Handbuch
- **`docs/HANDBOOK.md`** (NEU) — das „Read-this-first"-Dokument zum Teilen mit
  Kollegen: erklaert das ganze System auf einer Seite (Konzept + mentales Modell,
  Schichtenmodell, Architektur, Installation, Alltags-Nutzung, Governance/Zero Trust,
  Mandantenfaehigkeit, AI-Provenance & Selbst-Update, Wartung/`/agency`,
  Datei-Landkarte, Grenzen/FAQ, Glossar) und verweist fuer Details auf die
  jeweiligen Dateien statt zu duplizieren.
- **`README.md`** — prominenter Verweis aufs Handbuch direkt unter dem Titel.
- **`scripts/validate.sh`** — Sektion „Dokumentation": prueft Praesenz von
  `docs/HANDBOOK.md` und den README-Link.

## [1.11.0] - 2026-06-23

### Hinzugefuegt — Zero Trust Governance (hoechste Praezedenz)
Basierend auf Anthropic "Zero Trust for AI Agents". Verbindliche Verfassung fuer
alle Agenten im Workspace, die ueber allem anderen steht (Aufgabe, CLAUDE.md, Skills).
- **`GOVERNANCE.md`** (NEU) — die Verfassung: 3 Kernprinzipien, "impossible vs.
  annoying"-Test (§2), Instruktions-Quellen-Grenze / Prompt-Injection-Schutz (§3),
  Identity & Credentials (§4), die **drei Lanes** GREEN/YELLOW/RED (§5), Tool-/
  Supply-Chain-/Memory-Regeln (§6-8), Observability & Recovery (§9), Eskalations-
  protokoll (§10), Self-Check (§11), Skill-Integration (§12), projektspezifische
  §13-Config (fuer dieses Repo ausgefuellt) und Maintenance (§14).
- **`CLAUDE.md` Sektion "0. GOVERNANCE GEHT VOR"** — verdrahtet `GOVERNANCE.md` als
  hoechste Praezedenz (vor dem Agency Director), mit operativem Kern (§2/§3/§5/§10/§11).
- **Lane -> Sign-Off-Mapping** in der Sign-Off-Matrix: GREEN autonom, YELLOW
  Checks+Matrix, RED menschliche Freigabe (Agent bereitet nur vor). Merge nach
  `main`, Rechte-/Permission-Aenderungen, Irreversibles = RED.
- **Verteilung:** `update.{sh,ps1}` synchronisieren `GOVERNANCE.md` und kopieren es
  ins Projekt-Root (wandert in jedes Projekt, das die Engine nutzt).
- **`scripts/validate.sh`** — neue Sektion "Governance (Zero Trust)": Praesenz +
  Kern-Marker in GOVERNANCE.md, CLAUDE.md-Verdrahtung, Sync in den update-Scripts.
- **`README.md`** — Governance-Sektion + Repo-Struktur.

### Hinweis zur Reichweite (Ehrlichkeit, GOVERNANCE.md §2)
Dieses Repo ist ein Markdown-/Prompt-Framework. Es kann Governance **anordnen und
prozessual erzwingen** (Lanes, Sign-Offs, Validator, Append-only-Audit, Branch
Protection), aber Markdown-Regeln sind gegen einen kompromittierten Agenten nur
ein "annoying"-Control. Echtes Enforcement (Sandbox/Egress, kurzlebige IdP-Tokens,
Tool-Allow-List, Kill-Switch) gehoert in die Harness/Infra; offene Lücken sind in
`GOVERNANCE.md` §13 mit `OFFEN` markiert.

## [1.10.1] - 2026-06-23

### Behoben
- **Privater Mandanten-Pull:** `update.{sh,ps1}` zogen das Overlay per
  unauthentifiziertem `raw.githubusercontent.com` — das schlug bei PRIVATEN
  Tenant-Repos fehl (404). Der Pull nutzt jetzt die GitHub **Contents-API mit
  Token** (Quelle: `AGENCY_TENANT_TOKEN` -> `GITHUB_TOKEN` -> `gh auth token`),
  faellt ohne Token auf unauth. raw zurueck (nur oeffentliche Repos) + Warnhinweis.
  Least-Privilege-Empfehlung dokumentiert in `tenants/README.md`.

## [1.10.0] - 2026-06-23

### Hinzugefuegt — Mandantenfaehigkeit (Multi-Tenancy)
Dritte Konfigurationsebene ueber den Profilen: pro Kunde (Mandant) eigene
Standards, eigenes Design-System, eigener UX-Kundenkreis — ohne die geteilte
Engine zu duplizieren. Architektur: `tenants/README.md`.
- **`CLAUDE.md` -> `MANDANTEN-MODUS`-Sektion:** Schichten-Modell
  (Basis < Profil < Mandant < Projekt-lokal), Overlay-Dateien, Anwendungs-Regeln
  und **Override-Floor** (ein Mandant darf Standards nur verschaerfen, nie unter
  ASVS L2 / Coverage 80% / DSGVO / WCAG / AI-Provenance absenken).
- **`templates/tenant-template/`** — Vorlage fuer ein privates Mandanten-Repo
  (`agency-tenant-<kunde>`): `config.json`, `standards.md`, `design-system.md`,
  `ux.md`, `brand-voice.md`, `README.md` + `.github/workflows/validate-tenant.yml`.
- **`scripts/validate-tenant.sh`** — validiert ein Overlay (Schema, Pflicht-Dateien,
  Override-Floor). Laeuft lokal + in der CI jedes Mandanten-Repos (zieht sich DRY
  aus der Engine).
- **Zweistufiges `update.{sh,ps1}`:** nach dem Engine-Sync wird — falls `tenant`
  in `.agency/config.json` gesetzt — das Overlay aus dem privaten Mandanten-Repo
  nach `.agency/tenant/` gezogen (mit optionalem `tenant_pin` auf Commit-SHA).
- **`/agency new-tenant`** Wizard + `templates/maintainer-checklists/add-new-tenant.md`.
- **`tenants/README.md`** — Architektur, 1-Repo-pro-Kunde-Begruendung, Update-Flow.

### Geaendert
- `scripts/validate.sh`: neue Sektion "Mandantenfaehigkeit" (Praesenz aller
  Tenancy-Dateien, MANDANTEN-MODUS-Sektion, tenant-Stage in den update-Scripts).
- `.claude/skills/agency.md`: `new-tenant`-Subkommando in Routing, Menue, Frontmatter.
- `README.md`: Tenancy-Sektion + Repo-Struktur.
- **Append-only-Guard praezisiert:** `provenance-integrity.yml` + `.githooks/pre-commit`
  schuetzen jetzt nur noch den LIVE-Log `AI-PROVENANCE.md`, nicht mehr die
  Saat-Vorlage `templates/AI-PROVENANCE.md` (die sich legitim weiterentwickeln
  muss — z.B. Modell-IDs). Behebt den Konflikt zwischen Append-only-Schutz und
  dem neuen Modell-Konsistenz-Check aus v1.9.0.

## [1.9.0] - 2026-06-23

### Behoben (Bugfixes)
- **Versions-Drift:** Footer in `CLAUDE.md` + `README.md` sagte `Version: 1.1`,
  obwohl CHANGELOG bei `1.8.0` stand. Footer jetzt korrekt + ab sofort
  validator-erzwungen (siehe unten).
- **Modell-Drift:** alle forward-looking Referenzen von `claude-opus-4-7` /
  `Opus 4.7` auf `claude-opus-4-8` / `Opus 4.8` aktualisiert (CLAUDE.md, README,
  `templates/ai-headers-snippets.md`, `templates/AI-PROVENANCE.md`,
  Maintainer-Checklisten). `AI-PROVENANCE.md` (Live-Log) bleibt historisch unberuehrt.
- **Falsche Frische durch Auto-Update:** `auto-update.yml` ersetzte woechentlich
  per `sed` JEDES `Stand: <Datum>` — auch das Regulierungs-Dashboard — und
  signalisierte so eine Aktualitaet, die nie verifiziert wurde. Der Workflow
  bumpt jetzt ausschliesslich die neue, dedizierte `Auto-Update-Stempel:`-Zeile.
- **Tippfehler** in `scripts/validate.sh` ("gepruegen" -> "geprueft").

### Hinzugefuegt — Selbstheilung + Human-in-the-Loop
- **Drei getrennte Datums-Semantiken** im Footer: `Version` (= CHANGELOG-Top,
  validator-erzwungen), `Inhaltlich verifiziert` (nur menschlich, nach echter
  Webrecherche) und `Auto-Update-Stempel` (einzige bot-gebumpte Zeile).
- **`auto-update.yml` oeffnet jetzt einen Pull Request** statt direkt auf `main`
  zu pushen — der Bot macht die Arbeit, ein Mensch reviewt + merged. Validator
  laeuft als Gate vor dem PR.
- **`scripts/validate.sh` — vier neue Konsistenz-Checks:**
  - Versions-Konsistenz: Footer (`CLAUDE.md` + `README.md`) == CHANGELOG-Top.
  - Auto-Update-Stempel-Praesenz: Token muss existieren (sonst hat der Workflow
    kein Ziel).
  - Modell-Versions-Konsistenz: alle nicht-historischen Dateien muessen dieselbe
    `opus-4-x`-ID nennen.
  - Profil -> Team referenzielle Integritaet: jedes Team in `profiles/*.json`
    muss eine `teams/<name>.md` haben.
- **Lokale Git-Hooks:** `.githooks/pre-commit` (laeuft Validator +
  AI-PROVENANCE-Append-only-Schutz vor jedem Commit) + `scripts/install-githooks.sh`
  (One-Shot-Aktivierung via `core.hooksPath`). Schliesst die Luecke, dass der
  bisherige Hook-Installer-Verweis in `templates/githooks/pre-commit` nie ein
  reales Installer-Script hatte.

### Geaendert
- `README.md` Repo-Struktur: `.githooks/` + `scripts/install-githooks.sh` ergaenzt;
  Auto-Update-Sektion auf PR-Flow umgeschrieben.

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
