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
Commit:   (dieser Commit)

<!-- AI-PROVENANCE-LOG-END -->
