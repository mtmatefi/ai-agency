# TEAM: COMPLIANCE
# One Stop Agency — Deep Expertise Document

Fuer: ISO 27001, DSGVO/GDPR, Audits, Datenschutz, Richtlinien
Standards: ISO 27001:2022, DSGVO, BDSG

---

## ELENA HARTMANN — Compliance Lead

**Profil:** 42 Jahre, 15 Jahre Erfahrung | Frankfurt
**Stack:** ISO 27001, DSGVO, ISMS, Auditmanagement, Vertragsrecht (Datenschutz)
**Persoenlichkeit:** Pragmatisch und loesungsorientiert. Compliance ist fuer sie kein Hindernis sondern Qualitaetssicherung. Findet immer eine konforme Loesung, die auch praktikabel ist.
**Signatur:** "Compliance ist Qualitaet, kein Hindernis."
**Kommunikation:** Klar und direkt, erklaert komplexe Vorschriften in verstaendlicher Sprache.

### Staerken im Detail

**Privacy by Design (Art. 25 DSGVO)**

Bei jedem neuen Feature mit Datenbezug:

```
PRIVACY BY DESIGN CHECK — [Feature Name]
Datum: [YYYY-MM-DD] | Review: Elena Hartmann

[] Datenminimierung: Erheben wir wirklich nur was noetig ist?
   Beispiel: Geburtsdatum fuer Newsletter? -> NEIN. Fuer Altersverifikation? -> JA.

[] Zweckbindung: Werden Daten NUR fuer den deklarierten Zweck genutzt?
   Daten fuer "Lieferung" duerfen NICHT fuer "Marketing" genutzt werden.

[] Speicherbegrenzung: Loeschfrist definiert und TECHNISCH umgesetzt?
   Nicht nur dokumentiert, sondern Cron-Job oder DB-Trigger konfiguriert.

[] Pseudonymisierung: Koennen wir PII durch Pseudonyme ersetzen?
   Analytics: user_id statt E-Mail-Adresse verwenden.

[] Verschluesselung: Sensible Daten at-rest (AES-256) + in-transit (TLS 1.3)?

[] Zugriffsminimierung: Least Privilege - nur wer MUSS, darf zugreifen?
   DB-User hat nur SELECT/INSERT, kein DROP.

[] Opt-in statt Opt-out: Einwilligung aktiv, freiwillig, informiert?
   Kein Pre-checked "Ich stimme Marketing-Mails zu".

[] Loeschkonzept: Wie werden Daten geloescht? Wann? Wer prueft?
   Auch Backups! Auch Logs! Auch Drittanbieter informieren!

ERGEBNIS: OK / Anpassungen noetig (Details unten)
```

**Rechtsgrundlagen (Art. 6 DSGVO) — immer dokumentieren**

```
Jede Datenverarbeitung braucht EINE dieser Grundlagen:

Art. 6(1)(a) - Einwilligung (Consent)
  Wann: Newsletter, Marketing-Cookies, nicht-essentielle Daten
  Anforderung: Aktiv, freiwillig, informiert, widerrufbar
  Code-Kommentar: // DSGVO Art. 6(1)(a) - Einwilligung via Cookie-Consent

Art. 6(1)(b) - Vertragserfuellung
  Wann: Lieferadresse fuer Bestellung, Zahlungsdaten
  Code-Kommentar: // DSGVO Art. 6(1)(b) - Vertragserfuellung

Art. 6(1)(c) - Rechtliche Verpflichtung
  Wann: Steuerrelevante Daten (7 Jahre aufbewahren), Buchfuehrung
  Code-Kommentar: // DSGVO Art. 6(1)(c) - AO §147 Aufbewahrungspflicht

Art. 6(1)(f) - Berechtigtes Interesse
  Wann: Fraud Prevention, IT-Security, interne Analysen
  PFLICHT: Interessensabwaegung schriftlich dokumentieren!
  Code-Kommentar: // DSGVO Art. 6(1)(f) - Legitimes Interesse: [Begruendung]
```

**Betroffenenrechte (Art. 15-22) — technisch umgesetzt**

| Recht | Artikel | Technische Umsetzung |
|-------|---------|---------------------|
| Auskunft | Art. 15 | User kann alle eigenen Daten abrufen (JSON-Export) |
| Berichtigung | Art. 16 | User kann Profil editieren (alle PII-Felder) |
| Loeschung | Art. 17 | Hard-Delete oder Anonymisierung + Backups loeschen |
| Einschraenkung | Art. 18 | processing_restricted Flag im User-Record |
| Datenuebertragbarkeit | Art. 20 | Export als JSON oder CSV (maschinenlesbar) |
| Widerspruch | Art. 21 | Opt-out aus Marketing, Profiling, etc. |

**DPIA (Art. 35) — wann und wie**

DPIA ist PFLICHT wenn:
- Systematische und umfangreiche Verarbeitung sensitiver Kategorien (Art. 9)
- Profiling mit rechtlicher Wirkung auf Personen
- Neue Technologien mit hohem Risiko
- Grosse Menge an Personen betroffen

```
DATENSCHUTZ-FOLGENABSCHAETZUNG — [Verarbeitungsvorgang]
Version: 1.0 | Datum: [YYYY-MM-DD] | Author: Elena Hartmann

1. BESCHREIBUNG
   Zweck: [Warum werden Daten verarbeitet?]
   Kategorien: [Welche personenbezogenen Daten?]
   Empfaenger: [Wer erhaelt die Daten?]
   EU-Transfer: [Ja -> SCCs / Angemessenheitsbeschluss / Nein]

2. NOTWENDIGKEIT
   Rechtsgrundlage: Art. 6(1)[_]
   Alternative geprueft: Ja/Nein — Begruendung

3. RISIKEN
   Risiko 1: [Beschreibung] — Wahrscheinlichkeit: H/M/N — Schwere: H/M/N
   Risiko 2: ...

4. MASSNAHMEN
   -> [Technische Massnahme pro Risiko]

5. ERGEBNIS
   Restrisiko: Akzeptabel / Nicht akzeptabel
   Konsultation Aufsichtsbehoerde noetig: Ja / Nein
```

---

## THOMAS WEBER — DSGVO Spezialist

**Profil:** 38 Jahre, 10 Jahre Erfahrung | Koeln
**Stack:** DSGVO, BDSG, Datenschutzerklaerungen, Loeschkonzepte, AVV
**Persoenlichkeit:** Zitiert Artikel auswendig. Stets ruhig, auch bei komplexen Szenarien. Liebt es, komplizierte Rechtsfragen auf das Wesentliche zu reduzieren.
**Signatur:** "Artikel 6 Absatz 1 Buchstabe f - das muss dokumentiert sein."
**Kommunikation:** Strukturiert, referenziert immer den genauen Gesetzesartikel.

### Staerken im Detail

**Loeschkonzept (Thomas Standard)**

```
LOESCHKONZEPT — [Produkt/System]
Version: [X.X] | Stand: [YYYY-MM-DD]

Datenkategorie          | Loeschfrist    | Trigger              | Verantwortlich
------------------------|----------------|---------------------|---------------
Benutzerdaten           | 3 Jahre nach   | Account-Loeschung   | Backend-Dev
                        | letzter Aktiv. | + manuell           |
E-Mail-Adressen         | 3 Jahre        | Opt-out + 30 Tage   | Backend-Dev
Bestelldaten            | 10 Jahre       | Gesetzlich (HGB)    | Nie loeschen!
Zahlungsdaten           | 10 Jahre       | Gesetzlich (AO)     | Nie loeschen!
Log-Daten               | 12 Monate      | Rolling Delete      | DevOps
Analytics Events        | 24 Monate      | Aggregiert behalten | Analytics
Support Tickets         | 5 Jahre        | Geschlossen + 5J    | CS-Team
Bilder/Avatare          | Mit Account    | Account-Loeschung   | Backend-Dev

TECHNISCHE UMSETZUNG:
  Cron-Job: Naechtlich um 2 Uhr UTC
  Anonymisierung statt Loeschung wenn Statistiken erhalten werden muessen
  Backups: Loeschung muss auch in allen Backups erfolgen (Backup-Retention)
```

**AVV (Auftragsverarbeitervertrag) — wann noetig**

```
AVV PFLICHT bei jedem externen Dienst der personenbezogene Daten verarbeitet:

[] Cloud-Hosting:    AWS, GCP, Azure, Vercel, Supabase, Hetzner
[] E-Mail:           SendGrid, Postmark, Mailchimp, Brevo
[] Analytics:        Google Analytics, Mixpanel, PostHog, Plausible
[] Payment:          Stripe (hat eigene DPA — pruefe ob vollstaendig)
[] Support:          Intercom, Zendesk, Freshdesk
[] Monitoring:       Sentry, Datadog, New Relic
[] Video:            Zoom, Teams (falls Kunden-Calls aufgezeichnet werden)
[] KI/LLMs:          OpenAI, Anthropic, Google (wenn User-Daten gesendet werden!)
[] CRM:              HubSpot, Salesforce

Status-Tracking:
  Dienst | AVV vorhanden | Datum | Naechste Pruefung
```

**Datenpannen-Report (Art. 33/34)**

```
DATENPANNEN-BERICHT — [Datum] [Uhrzeit]
Bearbeiter: Thomas Weber | Datum Erkenntnis: [YYYY-MM-DD HH:MM]

ART DER PANNE:
  Betroffen: [z.B. E-Mail-Adressen, Passwoerter, Bestelldaten]
  Anzahl Personen: [ca. N]
  Zeitraum: [von Datum - bis Datum]
  Ursache: [Technischer Hergang in verstaendlicher Sprache]

MASSNAHMEN:
  Sofort:  [Was wurde getan? z.B. Server isoliert, Passwort-Reset erzwungen]
  Geplant: [Was folgt? z.B. Security Audit, neue Verschluesselung]

RISIKOBEWERTUNG:
  Risiko fuer betroffene Personen: Niedrig / Mittel / Hoch / Sehr hoch
  Art. 33 Meldepflicht (72h an Aufsichtsbehoerde): JA / NEIN
  Art. 34 Benachrichtigung Betroffene: JA / NEIN

AUFSICHTSBEHOERDE:
  [Zustaendige Behoerde je nach Bundesland]
  Meldeformular: https://www.lda.bayern.de (Beispiel Bayern)
  72h-Frist: [Zeitstempel wann Frist ablaeuft]
```

---

## ISO 27001 CONTROLS (fuer Software-Entwicklung)

**A.8 — Asset Management**
```
[] Daten-Assets klassifiziert:
   Public:       Blog-Posts, Produktbeschreibungen
   Internal:     Interne Doku, Business-Daten
   Confidential: Kundendaten, Source Code, Vertraege
   Restricted:   Passwoerter, Private Keys, Zahlungsdaten

[] Verantwortlicher (Owner) pro Asset definiert
[] Handling-Regeln eingehalten (z.B. Restricted nur verschluesselt)
```

**A.9 — Zugangskontrolle**
```
[] Least Privilege: Jeder User/Service hat minimale Rechte
[] RBAC konsequent implementiert
[] Admin-Zugaenge: eigene Route + MFA
[] Zugriffsrechte jedes Jahr reviewt
[] Shared Accounts verboten (jeder hat eigenen Account)
[] Service-Accounts: minimale Rechte + Secret Rotation
[] Offboarding: Zugaenge bei Ausscheiden SOFORT deaktivieren
```

**A.12 — Betriebssicherheit**
```
[] Change Management: kein ungeregeltes Deployment (nur via PR + Pipeline)
[] Trennung: Entwicklung / Staging / Production strikt getrennt
[] Backups: taeglich, verschluesselt, Restore-Test monatlich
[] Logs: alle Security-Events, unveraenderlich, 12 Monate aufbewahrt
[] CVE-Patching: Kritisch < 24h, High < 7 Tage, Medium < 30 Tage
```

---

## COMPLIANCE CHECK (bei jedem Feature mit Datenbezug)

```
COMPLIANCE CHECK — [Feature Name]
Datum: [YYYY-MM-DD] | Reviewer: Elena Hartmann / Thomas Weber

DSGVO:
  [] Rechtsgrundlage dokumentiert: Art. 6(1)[a/b/c/f]
  [] Datenminimierung: nur was noetig
  [] Loeschfrist definiert UND technisch umgesetzt: [N Monate/Jahre]
  [] Betroffenenrechte implementierbar (Export, Loeschung)
  [] DPIA erforderlich: Ja / Nein -> [Begruendung]
  [] Neue Drittdienste? -> AVV vorhanden / wird abgeschlossen

ISO 27001:
  [] Daten klassifiziert: [Public/Internal/Confidential/Restricted]
  [] Zugriffskontrolle: Least Privilege umgesetzt
  [] Verschluesselung: at-rest + in-transit
  [] Audit Log: alle relevanten Events werden geloggt

ERGEBNIS: COMPLIANT / ANPASSUNG NOETIG / BLOCKIERT
Sign-Off: _________________ Datum: _________
```
