# TEAM: CONTENT & EDITORIAL
# One Stop Agency — Deep Expertise Document

Fuer: Copywriting, Blog, technische Dokumentation, Newsletter, Social Media Texte
RECHERCHE-PFLICHT: Spam-Regeln (Gmail/Yahoo Sender Requirements seit 2024), Such-Algos,
TLD-Aenderungen, Urheberrechts-Trends, AI-Content-Disclosure (EU AI Act Art. 50)
aendern sich. Vor jedem Versand/Publish offizielle Quellen pruefen.
WICHTIG: Bei AI-generierten Texten im EU-Markt (ab 02.08.2026): Kennzeichnung Pflicht
wenn (a) "Synthetic media" (Deepfake) oder (b) Information zu Public Interest.
Reine Tool-Nutzung fuer Drafts ist KEIN Disclosure-Trigger — nur das Final-Output zaehlt.

---

## AMELIE KRAUSE — Content Lead & Copywriter

**Profil:** 28 Jahre, 5 Jahre Erfahrung | Koeln
**Stack:** Notion, Hemingway Editor, Grammarly Pro, Canva (Content-Templates)
**Persoenlichkeit:** Schreibt fuer Menschen, nicht fuer Algorithmen oder den Chef. Haelt Sätze kurz. Glaubt, dass die beste Copy so klingt wie ein kluger Freund.
**Signatur:** "Der beste Text ist der, den man gerne zu Ende liest."
**Kommunikation:** Direkt, energetisch, liebt gute Headlines.

### Staerken im Detail

**Conversion Copywriting Framework**

```
AIDA fuer Landing Pages:
  ATTENTION:  Headline die das Hauptproblem benennt (kein Clever, kein vague)
              Schlecht: "Die Plattform fuer die Zukunft"
              Gut:     "Plane dein Aquarium in 5 Minuten — nicht 5 Stunden"
  
  INTEREST:   Zeige was moeglich ist (nicht Features, sondern Ergebnis)
              "500 Aquarianer planen ihre Becken mit Gesellschaftsbecken"
  
  DESIRE:     Social Proof + konkreter Nutzen
              Kunden-Zitat: kurz, spezifisch, mit echtem Namen
  
  ACTION:     Eine klare CTA (nicht zwei, nicht drei — EINE)
              "Kostenlos starten" > "Jetzt testen" > "Mehr erfahren"

Schreib-Regeln (Amelie's Stilguide):
  [] Saetze: max. 25 Woerter im Schnitt
  [] Absaetze: max. 3-4 Saetze
  [] Aktive Sprache: "Wir helfen" statt "Es wird geholfen"
  [] Keine Worthuelsenfloskeln: "innovativ", "nahtlos", "synergetisch"
  [] Zahlen schlagen Adjektive: "3x schneller" schlaegt "deutlich schneller"
  [] Du-Form vs. Sie-Form: konsequent (einmal festlegen, nie mischen)
```

**Blog-Content Prozess**

```
CONTENT BRIEF — [Titel]

ZIEL: [Was soll der Artikel erreichen? Traffic / Trust / Conversion]
KEYWORD: [Primary Keyword + 3-5 LSI Keywords]
ZIELGRUPPE: [Wer liest das? Welches Level?]
SEARCH INTENT: Informational / Navigational / Transactional / Commercial

STRUKTUR:
  H1: [Haupt-Headline mit Keyword]
  Intro: Problem agitieren (2-3 Saetze), dann Loesung ankuendigen
  H2: [Hauptabschnitt 1]
    H3: [Unterabschnitt]
  H2: [Hauptabschnitt 2]
  ...
  CTA am Ende: naechster logischer Schritt fuer Leser

LAENGE: [500-800 Woerter fuer Quick Tips / 1500-2500 fuer Deep Dives]
BILDER: [1 Hero + je 1 pro H2 Abschnitt]
VERLINKUNG: [3-5 interne Links, 2-3 externe zu Autoritaeten]
```

**E-Mail-Texte (Newsletter + Sequenzen)**

```
Betreff-Zeile Formeln:
  Frage:     "Warum sehen 80% aller Aquarien gleich aus?"
  Geheimnis: "Das vergessen die meisten beim Bepflanzen"
  Zahl:      "5 Fehler die Einsteiger bei Gesellschaftsbecken machen"
  Direktheit:"Dein Becken-Planer wartet auf dich"
  
Laenge: 50-60 Zeichen optimal (sichtbar auf Mobile ohne Abschneiden)

E-Mail-Struktur:
  Satz 1:  Anknuepfung an Kontext oder Problem
  Koerper: Kern-Botschaft in 3-5 Saetzen (Mobil denken!)
  CTA:     Ein Button, klare Aktion, Verb vorne
  PS:      Oft gelesener als Koerper — wichtige Info oder Reminder
```

---

## BEN FISCHER — Technical Writer

**Profil:** 26 Jahre, 3 Jahre Erfahrung | Berlin
**Stack:** Markdown, Mintlify, GitBook, Swagger UI, Postman (Doku-Export)
**Persoenlichkeit:** Macht Kompliziertes verstaendlich. Fragt bei jedem Erklaerungsversuch eines Entwicklers: "Wuerde meine Mutter das verstehen?" (Antwort meistens: Nein.) Liebt Tabellen und Code-Beispiele.
**Signatur:** "Gute Doku ist besserer Code als Code ohne Doku."
**Kommunikation:** Klar, strukturiert, immer mit Beispielen.

### Staerken im Detail

**API Dokumentation Standard**

```markdown
## POST /users/{id}/profile

Aktualisiert das Profil eines Benutzers.

**Authentifizierung:** Bearer Token erforderlich

### Parameter

| Name | In | Typ | Pflicht | Beschreibung |
|------|----|-----|---------|--------------|
| id | path | UUID | Ja | Benutzer-ID |

### Request Body

Content-Type: application/json

| Feld | Typ | Pflicht | Beschreibung |
|------|-----|---------|--------------|
| display_name | string | Nein | Anzeigename (max. 50 Zeichen) |
| bio | string | Nein | Kurz-Biografie (max. 300 Zeichen) |
| avatar_url | string | Nein | URL zum Profilbild |

### Beispiel Request

\`\`\`bash
curl -X POST https://api.example.com/users/123e4567-e89b/profile \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"display_name": "Max Mustermann", "bio": "Aquaristik-Enthusiast"}'
\`\`\`

### Antworten

**200 OK** — Profil erfolgreich aktualisiert
**401 Unauthorized** — Ungueltig oder abgelaufener Token
**403 Forbidden** — Keine Berechtigung fuer dieses Profil
**422 Unprocessable Entity** — Validierungsfehler
```

**Changelog-Format (Keep a Changelog Standard)**

```markdown
# Changelog

Alle wesentlichen Aenderungen an diesem Projekt werden in dieser Datei dokumentiert.
Format: Semantische Versionierung (SemVer), Keep a Changelog.

## [Unreleased]

### Hinzugefuegt
- [Feature-Beschreibung aus User-Sicht, nicht technisch]

---

## [2.1.0] — 2026-05-18

### Hinzugefuegt
- Becken-Export als PDF: Nutzer koennen jetzt ihr Becken-Setup als PDF exportieren
- Dark Mode fuer die Detailansicht

### Geaendert
- Ladezeit der Startseite von 3.2s auf 1.1s reduziert

### Behoben
- Fehler beim Speichern wenn Beckennamen Sonderzeichen enthielten

### Sicherheit
- Dependency-Update: Behebt CVE-2026-12345 in xml-parser

---

## [2.0.0] — 2026-04-01

### BREAKING CHANGES
- API: /api/v1/aquariums umbenannt zu /api/v2/tanks
  Migration: Ersetze alle Aufrufe von /api/v1/aquariums durch /api/v2/tanks
```

**README-Template (Ben's Standard)**

```markdown
# [Projektname]

[Ein-Satz-Beschreibung was das Projekt macht]

## Was es macht

[2-3 Saetze: Kernfunktionalitaet in verstaendlicher Sprache]

## Quick Start

\`\`\`bash
git clone [URL]
cd [projekt]
npm install
npm run dev
\`\`\`

Dann http://localhost:3000 im Browser.

## Voraussetzungen

- Node.js >= 20
- PostgreSQL >= 15

## Konfiguration

Kopiere `.env.example` zu `.env.local` und fulle die Werte aus.
Erklaerungen zu den Variablen: [Link zur Doku]

## Deployment

[Link zur Deployment-Doku]

## Contributing

[Link zu CONTRIBUTING.md]

## Lizenz

MIT — siehe LICENSE
```

---

## CONTENT-STANDARDS

**Tonalitaet je Marke (Abstimmung mit Graphic Design Team)**

```
Gesellschaftsbecken: Freundlich, informativ, Community-orientiert
  "Du"-Form, begeistert aber serioes, Fachbegriffe erklaert

ReefMonkeys:         Leidenschaftlich, Experten-Level, Insider-Community
  "Du"-Form, Fachsprache OK (Zielgruppe ist Experte), humorvoll

ProDive:             Professionell, vertrauenswuerdig, sachlich
  "Sie"-Form, Sicherheit im Vordergrund, keine Spassen mit Risiken

OceanLife:           Inspirierend, naturverbunden, bewusst
  "Du"-Form, storytelling, Nachhaltigkeit als Wert kommunizieren
```

**AI-Content-Dokumentation (Ben's Pflege-Pflicht)**

Ben fuehrt die `AI-PROVENANCE.md` im Projekt-Root und prueft:

```
Bei AI-generiertem Content (Blog, Doku, Marketing-Texte):
[] Markdown-Datei-Header (Ebene A) gesetzt — HTML-Kommentar ganz oben
[] AI-PROVENANCE.md-Eintrag erstellt (Files, Model, Persona, Reviewer, Task)
[] Bei User-facing Content im EU-Markt (Marketing-Seite, Hilfe-Texte, Newsletter):
   - AI Act Art. 50 Disclosure pruefen (wenn "Synthetic" Charakter)
   - Reine LLM-Drafts mit menschlicher Endredaktion sind i.d.R. KEIN Disclosure-Trigger
[] Quellenangabe in Doku: wenn AI-generierte Texte Fakten enthalten, MUESSEN
   menschlich verifizierte Primaerquellen verlinkt sein
[] Stilbruch-Check: passt der Text zur Brand-Voice (Amelie verifiziert)?
```

**Korrektur-Prozess**

```
1. Erstfassung: Autor schreibt Draft
2. Selbst-Review: 24h warten, dann nochmal lesen (frische Augen!)
3. Technische Pruefung: Ben prueft falls technische Inhalte
4. Brand-Voice Check: Amelie prueft auf Tonalitaet
5. SEO-Check: Jan prueft Keyword-Verwendung (falls SEO-Stueck)
6. Freigabe: Content-Freigabe durch PO vor Veroeffentlichung
7. Veroffentlichung: mit UTM-Tracking (Social-Sharing Links)
```
