# Checkliste: Neue Regulierung integrieren

Wizard fuer `/agency new-regulation`. **Sehr web-recherche-intensiv** — die
meisten Daten kommen aus offiziellen Quellen, nicht aus LLM-Wissen.

## Pflicht-Webrecherche VOR dem Anfangen

```
Pflicht-Quellen pro Regulierung (Beispiele):
- EU: eur-lex.europa.eu, digital-strategy.ec.europa.eu, edpb.europa.eu
- DE: gesetze-im-internet.de, bsi.bund.de, BfDI
- US: nist.gov, cisa.gov, ftc.gov
- UK: gov.uk, ico.org.uk
- Internationale Standards: iso.org, owasp.org, nist.gov
```

Pro Regulierung MUSS dokumentiert sein:
- Voller offizieller Name (Verordnung XXXX/YYYY oder "Standard:Jahr")
- In-Kraft-Datum
- Anwendbarkeits-Datum (kann anders sein!)
- Quelle (URL + Abruf-Datum)

## Inputs

```
Regulierungs-Slug (kebab-case, z.B. "ccpa", "uk-online-safety-act"): ___
Voller Name: ___
Geographischer Anwendungsbereich (EU/DE/US/UK/...): ___
Rechtstyp (Verordnung/Gesetz/Standard/Norm): ___
In Kraft seit: YYYY-MM-DD
Voll anwendbar ab: YYYY-MM-DD
Wer ist betroffen (Schwelle, Sektoren): ___
Pflichten-Zusammenfassung (5-10 Bulletpoints): ___
Sanktionen: ___
Quellen-URLs (mind. 2 offizielle): ___
```

## Schritt 1 — CLAUDE.md: EU-Regulierungs-Dashboard erweitern

```
REGULIERUNG          STATUS              ANWENDBAR AB         BETRIFFT
...                  ...                 ...                  ...
<NEU>                <Status>            <Datum>              <Zielgruppe>
```

## Schritt 2 — CLAUDE.md: Elena (Compliance) Block ergaenzen

In der Elena-Sektion unter "Erweiterte Regulierungs-Pflicht-Checks (Stand YYYY-MM)":

```
- <Name>: <kurze Beschreibung + Trigger fuer Anwendung>
```

## Schritt 3 — teams/compliance.md: Voll-Sektion ergaenzen

Neue Sektion analog zu existierenden (CRA, EU AI Act, NIS2, Data Act, DORA):

```markdown
---

## <NAME> — <Status>-Datum

Voll anwendbar seit/ab YYYY-MM-DD.

Quelle (live verifizieren): <URL>

```
<NAME> SCOPE-CHECK:

SCHRITT 1: Bin ich betroffen?
  [] <Bedingung 1>
  [] <Bedingung 2>

SCHRITT 2: Pflichten (falls betroffen)
  [] <Pflicht 1>
  [] <Pflicht 2>
  ...

SANKTIONEN:
  ...
```
```

## Schritt 4 — teams/legal.md: EU-Digitalrecht-Sektion erweitern (falls EU-Regulierung)

Analog zu CRA, AI Act, Data Act, EAA - eigene Subsektion mit kompakten Checklist.

## Schritt 5 — CLAUDE.md: Sign-Off-Matrix erweitern (falls relevant)

Wenn die Regulierung neue Freigabe-Anforderungen schafft, neue Zeile in Sign-Off-Matrix:

```
| <neue Aktivitaet> | <Pflicht-Reviewer> | <Stellvertreter> |
```

## Schritt 6 — CLAUDE.md: ZUSAMMENARBEIT & ESKALATION erweitern

Unter "Regulierungs-getriebene Aktivitaeten":

```
- <Name>-Trigger -> <Lead-Persona> + <Co-Personas>
```

## Schritt 7 — profiles/*.json: Regulation-Slug ergaenzen wo zutreffend

Fuer jedes der 5 Standard-Profile entscheiden: enthaelt das Profil diese Regulierung?

Beispiel fuer eine neue Regulierung "ccpa" (kalifornisch, b2c-bezogen):
- `saas-eu-b2b.json` — wahrscheinlich nicht (EU-Fokus)
- `internal-tool.json` — nein
- `mobile-app-only.json` — nur wenn EU+US-Markt
- `agency-client-work.json` — ja, weil viele Kunden in USA
- `oss-library.json` — nein

## Schritt 8 — profiles/README.md updaten

Tabelle erweitern mit der neuen Regulierung als moegliche Option.

## Schritt 9 — Recherche-Pflicht-Tabelle in CLAUDE.md erweitern

Im RECHERCHE-PROTOKOLL-Abschnitt:

```
| <Domain neu> | <Pflicht-Quelle> |
```

## Schritt 10 — Validator + Test

```bash
bash scripts/validate.sh
# Muss gruen sein.

# Manueller Smoke-Test:
grep -r "<regulation-slug>" CLAUDE.md teams/compliance.md teams/legal.md profiles/
```

## Schritt 11 — CHANGELOG + AI-PROVENANCE + Commit

Sign-offs im Commit:
- mtmatefi (Repo-Eigner)
- (Empfehlung: bei echter rechtsverbindlicher Anwendung echten Anwalt einbeziehen
  — laut teams/legal.md WICHTIGE HINWEISE)
