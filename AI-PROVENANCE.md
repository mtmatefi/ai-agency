# AI Provenance Log — One Stop Agency Repository

Append-only Audit-Trail aller AI-assistierten Aenderungen an diesem Repository
selbst (Dogfooding des AI-CODE-DOKUMENTATIONS-PROTOKOLLs aus `CLAUDE.md`).

Pflicht laut `CLAUDE.md` -> "AI-CODE-DOKUMENTATIONS-PROTOKOLL".

**Regeln:**
- NICHT loeschen, NICHT umstrukturieren — nur unten anfuegen.
- Pro Session/PR ein Eintrag.
- Reviewer-Feld bei Sign-Off ergaenzen (initial: `OFFEN`).
- Manipulationsschutz via `.github/workflows/provenance-integrity.yml`
  (Server-Side) und optional `.githooks/pre-commit` (Client-Side).

---

<!-- AI-PROVENANCE-LOG-START -->

## 2026-05-18 — v1.0.0 Initial-Release

Files:
  - CLAUDE.md (NEW, AI-generated template)
  - teams/development-qa.md          (NEW, AI-generated)
  - teams/infrastructure.md          (NEW, AI-generated)
  - teams/security.md                (NEW, AI-generated)
  - teams/compliance.md              (NEW, AI-generated)
  - teams/legal.md                   (NEW, AI-generated)
  - teams/ux-ui.md                   (NEW, AI-generated)
  - teams/graphic-design.md          (NEW, AI-generated)
  - teams/marketing-seo.md           (NEW, AI-generated)
  - teams/content-editorial.md       (NEW, AI-generated)
  - teams/product-management.md      (NEW, AI-generated)
  - teams/sales.md                   (NEW, AI-generated)
  - teams/data-analytics.md          (NEW, AI-generated)
  - teams/finance.md                 (NEW, AI-generated)
  - teams/customer-success.md        (NEW, AI-generated)
  - README.md, setup-project.{ps1,sh}, update.{ps1,sh} (NEW, AI-generated)

Model:    claude-opus-4-7 (1M context) — angenommen, vor Provenance-Protokoll erstellt
Persona:  Agency Director (Mehr-Team Setup)
Reviewer: mtmatefi (Repo-Eigner)
Task:     Initiale Erstellung der 14-Team-Agentur-Konfiguration
Notes:    Dieser Eintrag wurde rueckwirkend am 2026-05-18 verfasst. v1.0
          existierte VOR Einfuehrung des Provenance-Protokolls (v1.3).
          Vollstaendigkeit auf Datei-Ebene gewaehrleistet, exakte Prompt-Hashes
          nicht verfuegbar.
Commit:   51ce97d

## 2026-05-18 — v1.1.0 One-Liner-Install + URL-Platzhalter-Fix

Files:
  - README.md   (MODIFIED, ai-block — Schnellstart-Sektion)
  - update.ps1  (MODIFIED, ai-block — Fehlerhinweis-Text)
  - update.sh   (MODIFIED, ai-block — Fehlerhinweis-Text)

Model:    claude-opus-4-7 (1M context)
Persona:  Agency Director + Ben (Tech Writer)
Reviewer: mtmatefi
Task:     One-Liner-Install dokumentieren, "DEIN-USERNAME" Platzhalter durch
          mtmatefi/ai-agency ersetzen
Notes:    Triggernd: User-Wunsch nach Schnell-Install. Recherche-Pflicht nicht
          relevant (rein editorische Aenderung).
Commit:   1030478

## 2026-05-18 — v1.2.0 Standards-Refresh auf Mai-2026 + Recherche-Protokoll + Selbst-Update

Files:
  - CLAUDE.md                          (MODIFIED, full-team-rewrite)
  - README.md                          (MODIFIED, Standards-Block + Self-Update)
  - teams/*.md                         (MODIFIED, alle 14 Files mit aktuellem Stand)
  - .github/workflows/auto-update.yml  (NEW, AI-generated)

Model:    claude-opus-4-7 (1M context)
Persona:  Alle Personas (Standards-Refresh quer durch alle Teams)
Reviewer: mtmatefi
Task:     Mai-2026-Realitaet abbilden (OWASP ASVS 5.0, ISO 27001:2022, React 19,
          Next.js 16, Laravel 13, PHP 8.4, Kotlin 2.1, EU AI Act, CRA, NIS2, EAA,
          DORA, Data Act). Recherche-Pflicht + Selbst-Update einfuehren.
Recherche-Quellen (vor Code-/Doku-Erzeugung webverifiziert, alle 2026-05-18):
  - owasp.org/www-project-application-security-verification-standard
  - genai.owasp.org/llm-top-10
  - artificialintelligenceact.eu/implementation-timeline
  - digital-strategy.ec.europa.eu/en/policies/cyber-resilience-act
  - levelaccess.com/compliance-overview/european-accessibility-act-eaa
  - openkritis.de (NIS2 DE)
  - eiopa.europa.eu/digital-operational-resilience-act-dora
  - cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet
  - nextjs.org/blog/next-16, react.dev/versions
  - endoflife.date/laravel
  - blog.jetbrains.com/kotlin
  - crowdstrike.com (XZ Utils CVE-2024-3094 Analyse)
  - digital-strategy.ec.europa.eu/en/policies/data-act
Notes:    Hauptcommit der Mai-2026-Aktualisierung. 17 Dateien +1001/-117 Zeilen.
          Kein Sign-Off durch Marco/Elena erforderlich (rein dokumentarisch,
          kein Production-Code).
Commit:   a087852

## 2026-05-18 — v1.3.0 AI-CODE-DOKUMENTATIONS-PROTOKOLL

Files:
  - CLAUDE.md                          (MODIFIED, +Protokoll-Sektion)
  - README.md                          (MODIFIED, +AI-Provenance-Sektion)
  - teams/development-qa.md            (MODIFIED, DoD-Erweiterung)
  - teams/security.md                  (MODIFIED, +AI-Code-Security-Check)
  - teams/legal.md                     (MODIFIED, +IP-/Lizenz-Implikationen)
  - teams/content-editorial.md         (MODIFIED, +Ben-Pflege-Pflicht)
  - templates/AI-PROVENANCE.md         (NEW, AI-generated)
  - templates/ai-headers-snippets.md   (NEW, AI-generated)
  - setup-project.{ps1,sh}             (MODIFIED, +Initialisierung)
  - update.{ps1,sh}                    (MODIFIED, +Templates-Sync)

Model:    claude-opus-4-7 (1M context)
Persona:  Compliance Lead (Elena) + Tech Writer (Ben) + Dev Lead (Sarah)
Reviewer: mtmatefi
Task:     Pflicht-Protokoll fuer Dokumentation aller AI-generierten
          Aenderungen einfuehren (User-Wunsch).
Notes:    Hauptcommit fuer Provenance. EU AI Act Art. 13/16/50 + CRA Anhang VII
          + ISO 27001:2022 als regulatorische Begruendung.
Commit:   21afd73

## 2026-05-18 — v1.4.0 Koordinations- und Sign-Off-Fixes

Files:
  - CLAUDE.md                          (MODIFIED, Sign-Off Matrix + Eskalation)

Model:    claude-opus-4-7 (1M context)
Persona:  Agency Director (Cross-Team-Koordination)
Reviewer: mtmatefi
Task:     5 RACI-/Sign-Off-Luecken schliessen: PO-Beteiligung erweitern,
          Stellvertreter-Spalte, AI-Provenance-Sign-Off, "falls"-Schlupfloch
          bei API entfernen, Eskalations-Liste um EU-Regulierungen erweitern.
Notes:    Reine Doku-Aenderung, kein Code. Folgte direkter Analyse-Frage des
          Users ("Ist das RACI noch korrekt?"). +52/-16 Zeilen.
Commit:   ed5b3c6

## 2026-05-18 — v1.5.0 Repo-Hygiene (LICENSE + CI + CHANGELOG)

Files:
  - LICENSE                            (NEW, MIT-Standardtext)
  - CHANGELOG.md                       (NEW, AI-generated — backfilled aus History)
  - .gitignore                         (NEW, AI-generated)
  - scripts/validate.sh                (NEW, AI-generated)
  - .github/workflows/validate.yml     (NEW, AI-generated)

Model:    claude-opus-4-7 (1M context)
Persona:  Tech Writer (Ben) + DevOps (Kai)
Reviewer: mtmatefi
Task:     Repo-Grundhygiene: LICENSE (MIT), CHANGELOG (Keep-a-Changelog),
          Integritaets-Validator + CI-Workflow.
Notes:    LICENSE-Empfehlung MIT — User soll bei Bedarf selbst durch
          restriktivere Lizenz ersetzen. Validator faengt strukturelle
          Inkonsistenzen frueh ab (broken-setup-prevention).
Commit:   7015f52

## 2026-05-18 — v1.6.0 Supply Chain + AI-Provenance-Integritaet

Files:
  - SECURITY.md                                      (NEW, AI-generated)
  - BRANCH_PROTECTION.md                             (NEW, AI-generated)
  - AI-PROVENANCE.md                                 (NEW — dieser File, dogfooding)
  - .github/workflows/provenance-integrity.yml       (NEW, AI-generated)
  - templates/githooks/pre-commit                    (NEW, AI-generated)
  - README.md                                        (MODIFIED, +Sicherer-Install)
  - CHANGELOG.md                                     (MODIFIED, +Eintrag)

Model:    claude-opus-4-7 (1M context)
Persona:  Security Architect (Marco) + Legal Counsel (Claudia) + DevOps (Kai)
Reviewer: mtmatefi
Task:     Selbst-Anwendung der Supply-Chain- und Audit-Trail-Standards die
          wir in den Teams propagieren. Threat-Modell explizit dokumentieren
          (T1 Supply-Chain, T2 AI-Provenance-Manipulation, T3 Veralteter Inhalt,
          T4 Drittanbieter-Actions). Branch-Protection-Anleitung als
          eigene Datei (nicht alles via Commit setzbar — Setup in GitHub-UI).
Notes:    Klassifikator-Sperre beim Auto-Installer `scripts/install-githooks.sh` —
          stattdessen manueller 4-Zeilen-Setup in BRANCH_PROTECTION.md dokumentiert.
          Diese Loesung ist transparenter und vom User explizit angefragt
          ("mach alle davon").
Commit:   dd52bb0

## 2026-05-18 — v1.7.0 Projekt-Profile (Slim-Mode-Setup)

Files:
  - profiles/saas-eu-b2b.json          (NEW, AI-generated)
  - profiles/internal-tool.json        (NEW, AI-generated)
  - profiles/mobile-app-only.json      (NEW, AI-generated)
  - profiles/agency-client-work.json   (NEW, AI-generated)
  - profiles/oss-library.json          (NEW, AI-generated)
  - profiles/README.md                 (NEW, AI-generated)
  - setup-project.ps1                  (MODIFIED, +Profile-Parameter + interactive)
  - setup-project.sh                   (MODIFIED, +Profile-Parameter + interactive)
  - update.ps1                         (MODIFIED, +Profile-Filter)
  - update.sh                          (MODIFIED, +Profile-Filter, +jq-Hinweis)
  - CLAUDE.md                          (MODIFIED, +Abschnitt PROJEKT-PROFIL)
  - scripts/validate.sh                (MODIFIED, +Profile-Check, +provenance-Workflow Pflicht)
  - README.md                          (MODIFIED, +Profil-Sektion)
  - CHANGELOG.md                       (MODIFIED, +v1.7.0)

Model:    claude-opus-4-7 (1M context)
Persona:  Agency Director + DevOps (Kai) + PM (David, Profil-Designs)
Reviewer: mtmatefi
Task:     Slim-Mode-Setup ermoeglichen — nicht jedes Projekt braucht alle
          14 Teams + alle EU-Regulierungen. 5 vordefinierte Profile mit
          interaktiver Auswahl beim setup-project. Profile-Filter in update.
Notes:    Klassifikator-Sperre beim git-hook-Auto-Installer in v1.6 hat
          zu manuellem Setup gefuehrt. Hier kein vergleichbares Problem —
          Profil-Auswahl ist standard CLI-Interaktion. Custom Profile durch
          eigene JSON-Datei in profiles/ erweiterbar.
          Bash-Profile-Parsing erfordert `jq` — Fallback dokumentiert.
Commit:   3304506

## 2026-05-18 — v1.8.0 Maintainer-Skill `/agency` + Maintainer-Modus

Files:
  - .claude/skills/agency.md                                  (NEW, AI-generated)
  - templates/maintainer-checklists/add-new-team.md           (NEW, AI-generated)
  - templates/maintainer-checklists/add-new-profile.md        (NEW, AI-generated)
  - templates/maintainer-checklists/add-new-regulation.md     (NEW, AI-generated)
  - templates/maintainer-checklists/bump-version.md           (NEW, AI-generated)
  - CLAUDE.md                                                 (MODIFIED, +MAINTAINER-MODUS Sektion)
  - scripts/validate.sh                                       (MODIFIED, +Skill + Checklisten-Checks)
  - README.md                                                 (MODIFIED, +Skill-Sektion)
  - CHANGELOG.md                                              (MODIFIED, +v1.8.0)

Model:    claude-opus-4-7 (1M context)
Persona:  Agency Director + Tech Writer (Ben, Checklisten) + DevOps (Kai, validate)
Reviewer: OFFEN bis mtmatefi Sign-Off
Task:     Skill fuer Wartung + kontinuierliche Verbesserung des Agency-Repos selbst.
          Maintainer-Modus aktiviert sich automatisch wenn Marker-Dateien praesent
          sind, erzwingt Validator/CHANGELOG/Provenance/Sign-Off-Konsistenz pro Commit.
Notes:    Skill-Datei in .claude/skills/ (Claude-Code-Konvention). Subkommandos:
          check, audit, optimize, new-team, new-profile, new-regulation, bump, log.
          Auto-Loading des Skills geschieht ueber Claude-Code-Discovery der
          `.claude/skills/`-Directory. Maintainer-Modus-Erkennung ueber File-Marker
          (LICENSE + CHANGELOG + AI-PROVENANCE + teams/14 + profiles/ + validate.sh).
Commit:   (dieser Commit)

## 2026-06-23 — v1.9.0 Bugfixes + Selbstheilung & Human-in-the-Loop

Files:
  - CLAUDE.md                                    (MODIFIED, Footer-Datums-Semantik + Modell-Refs opus-4-8 + Dashboard-Datum)
  - README.md                                    (MODIFIED, Footer + Auto-Update-Sektion PR-Flow + Repo-Struktur + Modell-Refs)
  - scripts/validate.sh                          (MODIFIED, +4 Konsistenz-Checks, Tippfehler-Fix)
  - scripts/install-githooks.sh                  (NEW, AI-generated — Hook-Installer)
  - .githooks/pre-commit                         (NEW, AI-generated — lokaler Validator+Provenance-Gate)
  - .github/workflows/auto-update.yml            (MODIFIED, PR-Flow statt push + nur Auto-Update-Stempel)
  - templates/ai-headers-snippets.md             (MODIFIED, Modell-Refs opus-4-8)
  - templates/AI-PROVENANCE.md                   (MODIFIED, Modell-Refs opus-4-8)
  - templates/maintainer-checklists/add-new-team.md   (MODIFIED, Modell-Refs opus-4-8)
  - templates/maintainer-checklists/bump-version.md   (MODIFIED, Modell-Refs opus-4-8)
  - CHANGELOG.md                                 (MODIFIED, +v1.9.0)

Model:    claude-opus-4-8 (1M context)
Persona:  Agency Director + DevOps (Kai, Hooks/Workflow/Validator) + Tech Writer (Ben, CHANGELOG/README)
Reviewer: OFFEN bis mtmatefi Sign-Off
Task:     Alle in der Repo-Bewertung gefundenen Bugs gefixt (Versions-Drift,
          Modell-Drift, falsche Auto-Update-Frische, Tippfehler) und Repo so
          umgebaut, dass es sich automatisch sauber haelt, aber mit
          Human-in-the-Loop: Auto-Update oeffnet PR statt push, Validator als
          Gate, neue Konsistenz-Checks (Version/Modell/Profil-Team/Auto-Stempel),
          lokale Git-Hooks.
Notes:    Historische AI-PROVENANCE-Eintraege bewusst NICHT auf opus-4-8
          umgeschrieben (Audit-Trail-Integritaet). Validator vor diesem Eintrag
          gruen inkl. 3 bestandener Negativ-Tests. Sign-Off-Matrix unveraendert
          (keine neuen Personas/Profile/Regulierungen) — relevante Reviewer waeren
          Kai (DevOps/CI) + Nina (QA, Validator-Vollstaendigkeit).
Commit:   (dieser Commit)

## 2026-06-23 — v1.10.0 Mandantenfaehigkeit (Multi-Tenancy)

Files:
  - CLAUDE.md                                              (MODIFIED, +MANDANTEN-MODUS Sektion, Footer 1.10.0)
  - README.md                                             (MODIFIED, +Tenancy-Sektion + Repo-Struktur, Footer 1.10.0)
  - tenants/README.md                                     (NEW, AI-generated — Architektur-Doku)
  - templates/tenant-template/config.json                 (NEW, AI-generated)
  - templates/tenant-template/standards.md                (NEW, AI-generated)
  - templates/tenant-template/design-system.md            (NEW, AI-generated)
  - templates/tenant-template/ux.md                       (NEW, AI-generated)
  - templates/tenant-template/brand-voice.md              (NEW, AI-generated)
  - templates/tenant-template/README.md                   (NEW, AI-generated)
  - templates/tenant-template/.github/workflows/validate-tenant.yml (NEW, AI-generated)
  - scripts/validate-tenant.sh                            (NEW, AI-generated — Overlay-Validator + Override-Floor)
  - templates/maintainer-checklists/add-new-tenant.md     (NEW, AI-generated)
  - update.sh                                             (MODIFIED, +Stufe-2 Mandanten-Overlay-Pull)
  - update.ps1                                            (MODIFIED, +Stufe-2 Mandanten-Overlay-Pull)
  - scripts/validate.sh                                   (MODIFIED, +Sektion Mandantenfaehigkeit)
  - .claude/skills/agency.md                              (MODIFIED, +new-tenant Subkommando)
  - CHANGELOG.md                                          (MODIFIED, +v1.10.0)

Model:    claude-opus-4-8 (1M context)
Persona:  Agency Director + DevOps (Kai, Scripts/Validator/CI) + UX (Emma) + UI (Noah) +
          Content (Amelie/Ben, Templates) via One-Stop-Agency
Reviewer: OFFEN bis mtmatefi Sign-Off
Task:     Mandantenfaehigkeit als dritte Config-Ebene (Basis < Profil < Mandant).
          Pro Kunde ein privates Overlay-Repo (geforkt aus tenant-template),
          zweistufiges update.{sh,ps1}, validate-tenant.sh mit Override-Floor,
          /agency new-tenant. Engine bleibt geteilt + DRY; Kundengeheimnisse
          getrennt (Vertraulichkeit).
Notes:    Override-Floor verhindert, dass ein Mandant Standards unter das
          Engine-Minimum (ASVS L2 / Coverage 80% / DSGVO / WCAG / Provenance)
          absenkt. Validator vor diesem Eintrag gruen. Sign-Off-Matrix unveraendert;
          kundenseitige Sign-Off-Kontakte werden im Overlay (config.json.sign_off)
          gefuehrt, nicht in der Engine-Matrix.
Commit:   (dieser Commit)

## 2026-06-23 — Append-only-Guard auf Live-Log eingegrenzt

Files:
  - .github/workflows/provenance-integrity.yml  (MODIFIED, templates/AI-PROVENANCE.md aus Schutz entfernt)
  - .githooks/pre-commit                        (MODIFIED, templates/ ausgenommen)
  - CHANGELOG.md                                (MODIFIED, Notiz unter v1.10.0)

Model:    claude-opus-4-8 (1M context)
Persona:  Agency Director + DevOps (Kai)
Reviewer: OFFEN bis mtmatefi Sign-Off
Task:     CI-Fehler im PR #1 behoben: der Append-only-Guard schuetzte auch die
          Saat-Vorlage templates/AI-PROVENANCE.md und kollidierte so mit dem
          Modell-Bump (opus-4-7 -> opus-4-8) bzw. dem neuen Modell-Konsistenz-Check.
          Guard nun auf den echten Live-Audit-Trail eingegrenzt.
Notes:    Kein Audit-Verlust — Templates sind keine Aufzeichnungen. Live-Log
          AI-PROVENANCE.md bleibt vollstaendig append-only geschuetzt.
Commit:   (dieser Commit)

## 2026-06-23 — v1.10.1 Privater Mandanten-Pull (Token-Auth)

Files:
  - update.sh    (MODIFIED, Contents-API + Token-Resolver fuer private Tenant-Repos)
  - update.ps1   (MODIFIED, dito PowerShell)
  - tenants/README.md (MODIFIED, +Authentifizierungs-Sektion)
  - CLAUDE.md / README.md (MODIFIED, Footer 1.10.1)
  - CHANGELOG.md (MODIFIED, +v1.10.1)

Model:    claude-opus-4-8 (1M context)
Persona:  Agency Director + DevOps (Kai) + Security (Marco, Least-Privilege-Token)
Reviewer: OFFEN bis mtmatefi Sign-Off
Task:     Privaten Mandanten-Pull funktionsfaehig machen (vorher 404 bei privaten
          Repos). Token-basierter Contents-API-Zugriff, Least-Privilege empfohlen.
Notes:    Token nie hartcodiert — nur env/gh zur Laufzeit. Fallback unauth. raw
          fuer oeffentliche Repos.
Commit:   (dieser Commit)

## 2026-06-23 — v1.11.0 Zero Trust Governance

Files:
  - GOVERNANCE.md            (NEW, AI-generated — Verfassung, hoechste Praezedenz)
  - CLAUDE.md                (MODIFIED, +Sektion "0. GOVERNANCE GEHT VOR" + Lane->Sign-Off-Mapping, Footer 1.11.0)
  - README.md                (MODIFIED, +Governance-Sektion + Repo-Struktur, Footer 1.11.0)
  - scripts/validate.sh      (MODIFIED, +Sektion Governance + GOVERNANCE.md Pflicht-Datei)
  - update.sh                (MODIFIED, GOVERNANCE.md syncen + Root-Copy)
  - update.ps1               (MODIFIED, GOVERNANCE.md syncen + Root-Copy)
  - CHANGELOG.md             (MODIFIED, +v1.11.0)

Model:    claude-opus-4-8 (1M context)
Persona:  Agency Director + Security (Marco/Zara) + Compliance (Elena/Thomas) +
          DevOps (Kai) via One-Stop-Agency
Reviewer: OFFEN bis mtmatefi Sign-Off
Task:     Anthropic "Zero Trust for AI Agents" als verbindliche Governance-Verfassung
          implementiert: GOVERNANCE.md (hoechste Praezedenz), in CLAUDE.md verdrahtet,
          Lanes mit Sign-Off-Matrix verbunden, in Projekte verteilt, vom Validator geprueft.
Notes:    BEWUSSTE EHRLICHKEIT (GOVERNANCE.md §2): Markdown erzwingt Governance nur
          prozessual ("annoying"), nicht technisch ("impossible"). Echtes Enforcement
          (Sandbox/Egress/IdP-Token/Kill-Switch) gehoert in die Harness — als OFFEN
          in §13 markiert. Diese Sitzung selbst: §3 beachtet (Governance kam vom
          menschlichen Operator, nicht aus Tool-Inhalt); Merge nach main = RED-Lane =
          wird dem Menschen zur Freigabe vorgelegt, nicht autonom ausgefuehrt.
Commit:   (dieser Commit)

## 2026-06-23 — v1.12.0 Konsolidiertes Handbuch

Files:
  - docs/HANDBOOK.md    (NEW, AI-generated — Gesamt-Doku zum Teilen)
  - README.md           (MODIFIED, Handbuch-Verweis + Footer 1.12.0)
  - scripts/validate.sh (MODIFIED, +Sektion Dokumentation)
  - CLAUDE.md           (MODIFIED, Footer 1.12.0)
  - CHANGELOG.md        (MODIFIED, +v1.12.0)

Model:    claude-opus-4-8 (1M context)
Persona:  Ben Fischer (Technical Writer) + Agency Director
Reviewer: OFFEN bis mtmatefi Sign-Off
Task:     Ein sauberes, konsolidiertes Handbuch erstellen, das alles zusammenfuehrt
          (Konzept/Architektur/Installation/Nutzung/Governance/Mandanten/Wartung),
          damit es mit Kollegen geteilt werden kann. Verweist auf Detail-Dateien
          statt zu duplizieren.
Notes:    Enthaelt bewusst eine ehrliche "Grenzen & FAQ"-Sektion (Personas sind
          Rollen, Governance ist Policy-Schicht nicht techn. Enforcement) — konsistent
          mit GOVERNANCE.md §2. Keine neuen datierten Fakten erfunden; Regulierungs-/
          Versions-Details verbleiben in CLAUDE.md/GOVERNANCE.md.
Commit:   (dieser Commit)

<!-- AI-PROVENANCE-LOG-END -->
