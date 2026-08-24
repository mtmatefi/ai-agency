# One Stop Agency

**14 Teams. 30+ Spezialisten. Automatisch aktiviert wenn du sie brauchst.**

Schreib deine Aufgabe — das richtige Team wird automatisch erkannt und handelt.
Kein manuelles Aktivieren. Kein Team-Management. Einfach arbeiten.

> 📖 **Neu hier oder willst du es mit Kollegen teilen? Starte mit dem
> [Handbuch (`docs/HANDBOOK.md`)](docs/HANDBOOK.md)** — erklaert das ganze System
> (Konzept, Architektur, Installation, Nutzung, Governance, Mandanten, Wartung)
> auf einer Seite. Diese README ist die Kurzfassung + Installation.

---

## Was ist das?

One Stop Agency ist eine zentrale `CLAUDE.md`-Konfiguration, die Claude (in Cursor,
Claude Code oder Cowork) in ein vollstaendiges digitales Agentur-Team verwandelt.
Du beschreibst was du brauchst — Claude erkennt welche Teams/Personen noetig sind
und handelt autonom bis zur definierten Freigabegrenze.

Es ist **kein Programm, sondern eine Konfiguration**: Markdown + ein paar Skripte,
die in dein Projekt kopiert werden und die Claude beim Oeffnen automatisch laedt.

---

## 📚 Dokumentation — was wofuer

| Dokument | Wofuer | Fuer wen |
|----------|--------|----------|
| **[docs/HANDBOOK.md](docs/HANDBOOK.md)** | **Read-this-first**: das ganze System auf einer Seite | alle / Kollegen |
| **[GOVERNANCE.md](GOVERNANCE.md)** | Zero-Trust-Verfassung (Regeln, hoechste Praezedenz) | alle |
| `CLAUDE.md` | Operative Doku, von Claude automatisch geladen (nicht zum Durchlesen) | Maschine |
| [tenants/README.md](tenants/README.md) | Mandantenfaehigkeit: Architektur + Flow | Maintainer |
| [profiles/README.md](profiles/README.md) | Profil-Schema | Maintainer |
| `SECURITY.md` · `BRANCH_PROTECTION.md` | Threat-Modell · main-Branch-Schutz | Security/Maintainer |
| `CHANGELOG.md` · `AI-PROVENANCE.md` | Aenderungs-Log · Audit-Trail | Audit |

> **Faustregel:** README = Schaufenster + Installation. HANDBOOK = die ganze Geschichte.
> Jede Detail-Info lebt an **einem** Ort, alles andere verlinkt darauf.

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

Volle Tiefe je Team: `teams/*.md`. Wie das Routing funktioniert: HANDBOOK §5.

---

## Standards (eingebaut, nicht konfigurierbar)

- **Security:** OWASP ASVS 5.0 Level 2 + OWASP Top 10 for LLM Applications 2025
- **Datenschutz:** ISO 27001:2022 + DSGVO (Privacy by Design, Art. 25)
- **Testing:** >= 80% Coverage, WCAG 2.1 AA (EAA-Pflicht), Core Web Vitals green
- **Prozess:** API-First (OpenAPI 3.1 vor Code), Keep a Changelog, Definition of Done
- **Supply Chain:** SBOM (CycloneDX/SPDX), Sigstore/Cosign-Signing
- **EU-Regulierung:** Tracker fuer NIS2 · EU AI Act · CRA · DORA · Data Act · EAA
- **AI-Provenance:** Pflicht-Doku jeder AI-generierten Aenderung (siehe HANDBOOK §8)

**Recherche-Pflicht:** LLM-Wissen veraltet. Jede Persona verifiziert Standards,
CVEs, Versionen und Gesetzes-Stand per Webrecherche vor jeder Empfehlung
(`CLAUDE.md` → "RECHERCHE-PROTOKOLL").

---

## Schnellstart

### Ein-Zeilen-Install (Windows / PowerShell)

```powershell
Invoke-WebRequest "https://raw.githubusercontent.com/mtmatefi/ai-agency/main/update.ps1" -OutFile update.ps1; .\update.ps1
```

### Ein-Zeilen-Install (Mac/Linux)

```bash
curl -fsSL https://raw.githubusercontent.com/mtmatefi/ai-agency/main/update.sh -o update.sh && bash update.sh
```

Danach Projekt in Cursor / Claude Code oeffnen — `CLAUDE.md` + `GOVERNANCE.md`
werden automatisch geladen.

> **Sicherheitshinweis:** Das ist `curl | bash`-aequivalent — du vertraust dem
> Repo + GitHub. Fuer hoehere Sicherheit: sicherer Install unten + `SECURITY.md`.

### Sicherer Install (Inspektion vor Ausfuehrung — empfohlen fuer Production)

```bash
git clone --depth 1 https://github.com/mtmatefi/ai-agency.git /tmp/agency
less /tmp/agency/update.sh /tmp/agency/GOVERNANCE.md /tmp/agency/SECURITY.md
bash /tmp/agency/setup-project.sh
```

### Pin auf bekannten guten Commit (maximale Reproduzierbarkeit)

```bash
SHA="7015f52"   # durch verifizierten Commit ersetzen
curl -fsSL "https://raw.githubusercontent.com/mtmatefi/ai-agency/$SHA/update.sh" -o update.sh
AGENCY_REPO_URL="https://raw.githubusercontent.com/mtmatefi/ai-agency/$SHA" bash update.sh
```

```powershell
# Windows-Aequivalent
$Sha = "7015f52"
Invoke-WebRequest "https://raw.githubusercontent.com/mtmatefi/ai-agency/$Sha/update.ps1" -OutFile update.ps1
.\update.ps1 -RepoUrl "https://raw.githubusercontent.com/mtmatefi/ai-agency/$Sha"
```

Threat-Modell siehe `SECURITY.md`, Branch-Protection siehe `BRANCH_PROTECTION.md`.

### Aktualisieren

```bash
bash update.sh          # Mac/Linux
.\update.ps1            # Windows
```
Empfehlung: taeglich per Cron / Task Scheduler (Beispiele in HANDBOOK §8).

---

## Projekt-Profile — nicht jedes Projekt braucht alle 14 Teams

Beim `setup-project` wird ein Profil gewaehlt (Default `saas-eu-b2b`). Es bestimmt
welche Teams aktiv sind und welche EU-Regulierungen Pflicht-Check sind:

| Profil | Teams | Regulierungen | Use-Case |
|--------|-------|---------------|----------|
| `saas-eu-b2b` | alle 14 | DSGVO, AI Act, CRA, NIS2, EAA, Data Act | Voll-SaaS, EU-B2B |
| `internal-tool` | 5 | DSGVO | Interne Tools, Admin-Portale |
| `mobile-app-only` | 7 | DSGVO, AI Act, EAA | Mobile-App-Projekt |
| `agency-client-work` | 11 | DSGVO, AI Act, CRA, EAA | Agentur, wechselnde Kunden |
| `oss-library` | 5 | CRA | OSS-Library / SDK |

```bash
bash setup-project.sh --profile internal-tool      # Mac/Linux
.\setup-project.ps1 -Profile internal-tool         # Windows
```

Schema + eigene Profile: `profiles/README.md`.

---

## Mehr im Detail (Kurzfassung + Link)

- **Governance / Zero Trust** — `GOVERNANCE.md` ist die Verfassung (hoechste
  Praezedenz): Instruktions-Quellen-Grenze gegen Prompt-Injection, drei Lanes
  🟢/🟡/🔴, RED = menschliche Freigabe. → [GOVERNANCE.md](GOVERNANCE.md) · HANDBOOK §6
- **Mandantenfaehigkeit** — pro Kunde ein privates Overlay-Repo (Standards/Design/
  UX/Brand), Engine bleibt geteilt; Override-Floor erzwingt Mindeststandards.
  → [tenants/README.md](tenants/README.md) · HANDBOOK §7
- **AI-Provenance** — Pflicht-Doku jeder AI-Aenderung (Header, Block-Marker,
  append-only `AI-PROVENANCE.md`). → `CLAUDE.md` "AI-CODE-DOKUMENTATIONS-PROTOKOLL" · HANDBOOK §8
- **Selbst-Update (3 Ebenen)** — woechentlicher Auto-Update-PR, taeglicher
  Downstream-Sync, Live-Recherche je Persona. → HANDBOOK §8
- **Wartung `/agency`** — Maintainer-Skill (`check`, `audit`, `optimize`,
  `new-team/profile/tenant/regulation`, `bump`, `log`). → HANDBOOK §9 · `.claude/skills/agency.md`

Vollstaendige Datei-Landkarte: **HANDBOOK §10**.

---

## Eigenen Fork verwenden (optional)

Die Standard-URL zeigt auf `mtmatefi/ai-agency`. Eigener Fork? Per Parameter /
Env-Variable ueberschreiben — Skripte selbst musst du nicht editieren:

```bash
# Mac/Linux (einmalig / dauerhaft in ~/.zshrc)
AGENCY_REPO_URL="https://raw.githubusercontent.com/DEIN-USERNAME/DEIN-REPO/main" bash update.sh
```
```powershell
# Windows
.\update.ps1 -RepoUrl "https://raw.githubusercontent.com/DEIN-USERNAME/DEIN-REPO/main"
```

---

Version: 1.12.0 | Inhaltlich verifiziert: 2026-05-18 | Auto-Update-Stempel: 2026-08-24
Stack: React 19 / TS 5.x / Next.js 16 | PHP 8.4 / Laravel 13 | Kotlin 2.1 / Compose 2026.04 | Supabase / Postgres 17
Standards: OWASP ASVS 5.0 L2 | OWASP LLM Top 10 (2025) | ISO 27001:2022 | DSGVO | WCAG 2.1/2.2 AA | EAA
EU-Regulierung: NIS2 (DE 06.12.2025) · AI Act (voll 02.08.2026) · CRA (Reporting 11.09.2026) · DORA · Data Act
