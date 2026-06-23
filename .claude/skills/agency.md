---
name: agency
description: Wartungs- und Optimierungs-Skill fuer das mtmatefi/ai-agency Repo. Verwende diesen Skill wenn du das Agency-Repo selbst veraenderst — fuer guided Aenderungen, Integritaets-Pruefung, kontinuierliche Optimierung. Subkommandos `check`, `audit`, `new-team`, `new-profile`, `new-tenant`, `new-regulation`, `bump`, `optimize`, `log`. Bei `/agency` ohne Argument: Menue + Status.
---

# Agency Maintainer Skill

Du bist jetzt im **Maintainer-Modus** des `mtmatefi/ai-agency` Repos.
Ziel: die Agency richtig editieren, sauber halten, kontinuierlich verbessern.

## Aktivierungs-Pruefung (ZUERST)

Bevor du irgendwas tust, **stelle sicher dass du im Agency-Repo bist**, nicht in
einem Zielprojekt:

```bash
# Diese Dateien muessen alle existieren — sonst NICHT der Agency-Repo:
ls CLAUDE.md README.md LICENSE CHANGELOG.md AI-PROVENANCE.md \
   SECURITY.md BRANCH_PROTECTION.md teams/ profiles/ scripts/validate.sh
```

Wenn das nicht der Agency-Repo ist, sage dem User: "Dieser Skill ist nur fuer
das Agency-Repo (mtmatefi/ai-agency). Du bist in {detected dir}. Skill abgebrochen."

## Subkommando-Routing

Wenn User `/agency <cmd>` schreibt, gehe zum entsprechenden Abschnitt unten.
Bei `/agency` ohne Argument: erst Status anzeigen, dann das Menue.

| Subkommando | Was es macht |
|-------------|--------------|
| `check`             | Validator-Run + kurzer Status-Bericht |
| `audit`             | Tiefe Integritaets- und Konsistenzpruefung |
| `optimize`          | Kontinuierliche-Verbesserungs-Analyse (mit Webrecherche) |
| `new-team`          | Guided: neues Team hinzufuegen |
| `new-profile`       | Guided: neues Profil hinzufuegen |
| `new-tenant`        | Guided: neuen Mandanten (Kunde) anlegen |
| `new-regulation`    | Guided: neue EU-/internationale Regulierung integrieren |
| `bump <m\|n\|p>`    | Versions-Bump (major/minor/patch) inkl. CHANGELOG + AI-PROVENANCE |
| `log "<task>"`      | Korrekt formatierten AI-PROVENANCE.md-Eintrag anfuegen |
| `menu` / (leer)     | Menue + Status anzeigen |

---

## /agency check

```bash
bash scripts/validate.sh
```

Wenn Exit 0: Status-Bericht mit:
- Letzter Commit (`git log -1 --oneline`)
- Aktuelle Version (aus `CHANGELOG.md` letzter Eintrag)
- Anzahl Team-Files / Profile / Workflows
- Datum seit letztem Auto-Update (`git log -1 --format=%cI .github/workflows/auto-update.yml`)

Wenn Exit ≠ 0: Fehler auflisten + Fix-Vorschlag pro Fehler.

---

## /agency audit

Tiefere Pruefung als `check` (validate.sh deckt nur Datei-Praesenz).
Pruefe folgendes (bei jedem Punkt: Treffer = WARN oder FAIL):

1. **Persona-Konsistenz**
   - Jede Persona, die in `CLAUDE.md` (TEAM-ROUTING oder Sign-Off-Matrix) genannt
     wird, MUSS in mindestens einem `teams/*.md` als Header (`## NAME`) vorkommen.
   - Personas, die in `teams/*.md` definiert sind aber nirgends in `CLAUDE.md`
     referenziert werden, sind "verwaiste Personas".

2. **Team-File-Balance**
   - Pruefe Zeilenzahl jedes `teams/*.md`. Standard-Range: 150-500 Zeilen.
   - Files unter 100 → "moeglicherweise zu duenn"
   - Files ueber 700 → "moeglicherweise zu lang, splitten?"

3. **Sign-Off-Matrix-Konsistenz**
   - Jeder in Sign-Off-Matrix genannte Persona existiert?
   - Jeder Stellvertreter existiert?
   - PO (David) ist Pflicht bei produktrelevanten Releases?

4. **Profile-Konsistenz**
   - Jedes Profile referenziert nur existierende Team-Slugs?
   - Jede Regulierung im Profile ist in `CLAUDE.md`/`teams/compliance.md`
     dokumentiert?

5. **Standards-Aktualitaet** (mit Webrecherche!)
   - OWASP ASVS Current Version: `WebSearch "OWASP ASVS latest version 2026"`
   - WCAG Current: `WebSearch "WCAG current AA 2026"`
   - ISO 27001 Current: `WebSearch "ISO 27001 current version 2026"`
   - Wenn Realitaet abweicht von `CLAUDE.md` → FAIL mit Vorschlag.

6. **CHANGELOG vs. Git**
   - Anzahl Commits seit letztem Tag/Version-Eintrag in CHANGELOG.
   - Wenn > 5 Commits ohne CHANGELOG-Update → WARN.

7. **AI-PROVENANCE vs. Commits**
   - Jeder Commit mit `Co-Authored-By: Claude` sollte einen entsprechenden
     AI-PROVENANCE.md-Eintrag haben.
   - Stichprobe: letzte 10 Commits checken.

8. **Branch-Protection-Status**
   - `gh api repos/mtmatefi/ai-agency/rulesets 2>/dev/null` — sind die Regeln gesetzt?
   - Wenn nein → WARN mit Verweis auf BRANCH_PROTECTION.md.

Output-Format: ein Report mit Sektionen oben, pro Sektion OK/WARN/FAIL mit Beispiel + Fix-Vorschlag.

---

## /agency optimize

Kontinuierliche Verbesserung — gehe alle Punkte mit Webrecherche durch:

1. **Neue EU-/Internationale Regulierungen seit Stand-Datum?**
   - `WebSearch "EU AI Act news YYYY-MM"` (aktuelles Datum)
   - `WebSearch "NIS2 implementing acts 2026"`
   - `WebSearch "Cyber Resilience Act guidelines 2026"`
   - Wenn neue Leitlinien/Durchfuehrungsakte: WARN + Vorschlag zur Aufnahme.

2. **Neue Framework-Major-Releases?**
   - `WebFetch endoflife.date/api/react.json` etc. (Liste in templates)
   - Wenn unsere Doku < latest stable: FAIL mit Update-Vorschlag.

3. **Neue OWASP-Releases? Neue CVEs in unserer Stack-Empfehlung?**
   - `WebSearch "OWASP ASVS update YYYY"`, `"OWASP Top 10 update YYYY"`.

4. **Wo fehlt Tiefe? Welches Team haette mehr verdient?**
   - Lies jedes `teams/*.md` und compare gegen ein imaginaeres "Best-in-Class".
   - Beispiele:
     - Hat Sarah (Backend) Beispiele fuer Laravel-Queue-Architektur? Ja/Nein.
     - Hat Marco threat-model-Templates fuer LLM-Agentic-Apps? Ja/Nein.
   - Sammle 3-5 konkrete Tiefen-Verbesserungs-Vorschlaege.

5. **Welche Profile fehlen?**
   - Aktuelle Profile-Liste pruefen. Gibt es haeufige Use-Cases ohne Profil?
   - Beispiele zur Inspiration: "fintech-saas" (DORA+CRA+DSGVO), "media-publishing"
     (Urheberrecht+AI Act Art. 50), "behoerden-projekt" (sehr restriktiv,
     keine OSS-Verbindlichkeit), "iot-product" (Data Act stark).

6. **Welche Personas haben veraltete Tools?**
   - z.B. "Sophie's Stack erwaehnt Google Analytics 4 — was war GA5?".
   - Webrecherche pro Persona-Tool-Liste.

7. **Konsistenz der Sprache (DE/EN)**
   - Alle Personas-Files in DE? Stilbruch irgendwo?

Output: Bericht in 7 Sektionen mit konkreten, **priorisierten** Verbesserungs-Vorschlaegen.
Klassifiziere jede Empfehlung als P0/P1/P2 (P0 = jetzt fixen, P1 = nachste Iteration, P2 = nice-to-have).

**Nach dem Bericht:** Frage den User: "Soll ich Punkte X, Y, Z direkt umsetzen?"
Bei "ja" → durchfuehren + ein Commit pro logischer Aenderungsgruppe.

---

## /agency new-team

Verwende `templates/maintainer-checklists/add-new-team.md` als Schritt-fuer-Schritt-Anleitung.
Gehe sie mit dem User durch, frage Werte ab, schreibe die Dateien, ergaenze
Routing/Sign-Off-Matrix/Profile/etc. Am Ende: `/agency check`, dann CHANGELOG +
AI-PROVENANCE-Eintrag + Commit-Vorschlag.

---

## /agency new-profile

Verwende `templates/maintainer-checklists/add-new-profile.md`.

---

## /agency new-tenant

Verwende `templates/maintainer-checklists/add-new-tenant.md`.
Wichtig: ein Mandant ist ein eigenes PRIVATES Overlay-Repo (`agency-tenant-<kunde>`,
geforkt aus `templates/tenant-template/`), NICHT eine Aenderung am Engine-Repo.
Architektur: `tenants/README.md`. Schema/Precedence/Override-Floor: `CLAUDE.md`
-> `MANDANTEN-MODUS`. Vor Abschluss: `bash scripts/validate-tenant.sh <pfad>`.

---

## /agency new-regulation

Verwende `templates/maintainer-checklists/add-new-regulation.md`.
Dieser Wizard ist besonders web-recherche-intensiv — die meisten Daten kommen
nicht aus dem LLM-Wissen, sondern aus eur-lex.europa.eu und Konsorten.

---

## /agency bump <major|minor|patch>

1. Letzte Version aus `CHANGELOG.md` lesen.
2. Neue Version berechnen (semver).
3. Commits seit letzter Version sammeln (`git log {LAST_TAG}..HEAD --oneline`).
4. Neuen CHANGELOG-Block schreiben (Hinzugefuegt/Geaendert/Behoben/Sicherheit).
5. AI-PROVENANCE.md-Eintrag fuer den Bump anfuegen (unter LOG-END marker).
6. Versions-String in CLAUDE.md-Footer + README-Footer updaten.
7. Validator durchlaufen lassen (muss gruen sein).
8. Commit-Vorschlag formatieren: `chore(release): v{NEW_VERSION}`.
9. Tag-Vorschlag: `git tag -a v{NEW_VERSION} -m "Release v{NEW_VERSION}"`.

---

## /agency log "<task description>"

Generiert einen sauber formatierten AI-PROVENANCE.md-Eintrag:
1. Get-Changes: `git status --porcelain` + `git diff --stat HEAD`.
2. Klassifiziere Files: NEW vs. MODIFIED, mit Block-Bereich falls partiell.
3. Persona ermitteln: aus den File-Pfaden (z.B. teams/security.md -> Marco/Zara) +
   aus dem Task-Text (Keyword-Match).
4. Reviewer: aus `git config user.name`. Falls Reviewer fuer Files unklar: OFFEN.
5. Datum: `date -u +%Y-%m-%d`.
6. Anfuegen UEBER dem `<!-- AI-PROVENANCE-LOG-END -->` Marker.
7. KEINE bestehenden Eintraege aendern (append-only — siehe
   `.github/workflows/provenance-integrity.yml`).

---

## /agency menu (Default)

Wenn `/agency` ohne Argument:

```
Agency Maintainer — Status
==========================
Repo:       {pwd}
Version:    {aus CHANGELOG}
Last commit:{git log -1 --oneline}
Validator:  {OK/FAIL — kurzer Lauf von validate.sh}

Verfuegbare Subkommandos:
  /agency check          — schnelle Integritaets-Pruefung
  /agency audit          — tiefe Konsistenz- und Standards-Pruefung
  /agency optimize       — kontinuierliche Verbesserung (mit Webrecherche)
  /agency new-team       — neues Team hinzufuegen (guided)
  /agency new-profile    — neues Profil hinzufuegen (guided)
  /agency new-tenant     — neuen Mandanten (Kunde) anlegen (guided)
  /agency new-regulation — neue EU-Regulierung integrieren (guided)
  /agency bump           — Versions-Bump
  /agency log            — AI-PROVENANCE-Eintrag schreiben
```

---

## Globale Pflichten (gelten in jedem Subkommando)

1. **Recherche-Pflicht** (aus CLAUDE.md) gilt auch hier: vor jeder datierten
   Aussage WebSearch nutzen, Quelle+Datum zitieren.
2. **AI-Provenance** fuer jede Aenderung die du selbst machst: Datei-Header
   oder Block-Marker setzen, AI-PROVENANCE.md ergaenzen.
3. **Validator** muss gruen bleiben — vor jedem Commit-Vorschlag.
4. **Append-only** fuer CHANGELOG und AI-PROVENANCE — niemals alte Eintraege editieren.
5. **Co-Authored-By: Claude** in jedem Commit den du vorschlaegst.
6. **PO (David)-Sign-Off-Hinweis** bei produktrelevanten Aenderungen
   (Default: Sign-Off-Liste im Commit-Body als Checkbox auflisten).
