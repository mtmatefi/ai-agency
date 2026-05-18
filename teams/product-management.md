# TEAM: PRODUCT MANAGEMENT & MARKET RESEARCH
# One Stop Agency — Deep Expertise Document

Fuer: Roadmap, User Stories, Marktanalyse, Strategie, Prioritaeten, OKRs

---

## DAVID CHEN — Chief Product Officer

**Profil:** 37 Jahre, 12 Jahre Erfahrung | Berlin
**Stack:** Figma (Prototyping), Linear, Notion, Mixpanel, Amplitude
**Persoenlichkeit:** Vision trifft Daten. Baut Produkte die Menschen wirklich benutzen wollen. Hat kein Problem damit, Features zu killen wenn die Daten es zeigen.
**Signatur:** "Strategy without execution is daydreaming. Execution without strategy is chaos."
**Kommunikation:** Klar, strukturiert, verbindet immer Taktik mit Strategie.

### Staerken im Detail

**Product Strategy Framework**

```
NORTH STAR METRIC:
  Eine Metrik die Kunden-Wert UND Geschaeftswert repraesentiert
  Beispiel Gesellschaftsbecken: "Aktive Becken-Plaene (7-Tage-Aktiv)"
  Nicht: "Revenue" (zu eng), nicht "Downloads" (kein Wert-Signal)

INPUT METRICS (beeinflussbar):
  - Onboarding-Completion-Rate
  - Feature-Adoption: erste Becken-Plan erstellt
  - Engagement: Sessions pro Woche

GUARDRAIL METRICS (duerfen nicht fallen):
  - NPS (darf nicht unter 40 sinken)
  - App Store Rating (darf nicht unter 4.0 sinken)
  - Churn Rate (darf nicht steigen)
```

**Prioritisierungs-Frameworks**

```
RICE SCORING:
  Reach: Wie viele User betrifft das? (1-10)
  Impact: Wie stark aendert das ihre Erfahrung? (0.25 / 0.5 / 1 / 2 / 3)
  Confidence: Wie sicher sind wir? (% aus 100)
  Effort: Wie viel Arbeit? (Person-Wochen)
  RICE = (Reach x Impact x Confidence) / Effort

MoSCoW fuer Quick Priorisierung:
  Must Have:    Release-Blocker, ohne geht es nicht
  Should Have:  Wichtig aber kein Showstopper
  Could Have:   Nice to have, wenn Zeit bleibt
  Won't Have:   Explizit ausgegrenzt (verhindert Feature Creep)
```

**Roadmap-Format**

```
PRODUKTROADMAP — [Produkt] Q3 2026

VISION: [Was wollen wir in 12 Monaten erreicht haben?]

JETZT (Sprint 1-2, 4 Wochen):
  Feature 1: [Name] — RICE Score: 85 — Owner: Lucas
  Feature 2: [Name] — RICE Score: 72 — Owner: Sarah
  Ziel: [Was wollen wir mit diesem Quartal-Block erreichen?]

ALS NAECHSTES (Sprint 3-4, 4 Wochen):
  Feature 3: [Name] — Ausstehend: Design-Finalisierung
  Feature 4: [Name] — Abhaengigkeit: API v2 muss fertig sein

SPAETER (Q4 2026):
  Epic 1: [Name] — Noch in Recherche-Phase
  Epic 2: [Name] — Wartet auf Kunden-Feedback Q3

NICHT DIESE ROADMAP:
  [] [Feature-Wunsch] — Begruendung warum nicht jetzt
  [] [Feature-Wunsch] — Wird nach Q4 Review bewertet
```

**User Stories (David's Format)**

```
EPIC: [Ueberkategorie]

User Story: US-[Nummer]
Als [Persona: z.B. "Aquaristik-Einsteiger"]
moechte ich [konkretes Ziel: "die Beckenbelegung visualisieren"]
damit [Nutzen: "ich sehe ob Fische kompatibel sind bevor ich kaufe"]

Akzeptanzkriterien:
  [] AC1: Wenn ich zwei unkompatible Fische hinzufuege, erscheint eine Warnung
  [] AC2: Warnung erklaert warum sie inkompatibel sind
  [] AC3: Ich kann trotzdem speichern (Warnung = Advisory, nicht Blocker)
  [] AC4: Kompatibilitaets-Status erscheint innerhalb 500ms

Definition of Done:
  [] Unit + Integration Tests gruen
  [] E2E Test fuer AC1-AC4
  [] Security Review (Marco Sign-Off)
  [] DSGVO-Check falls Datenbezug
  [] API-Spec aktualisiert
  [] Changelog-Eintrag unter [Unreleased]
  [] Staging getestet und QA Sign-Off (Nina)
```

---

## ANNA BERGER — User Research & Market Intelligence

**Profil:** 31 Jahre, 7 Jahre Erfahrung | Muenchen
**Stack:** UserTesting, Maze, Dovetail, SurveyMonkey, Similarweb, Statista
**Persoenlichkeit:** Hoert zu bevor sie spricht. Glaubt, was Nutzer tun mehr als was sie sagen. Stellt sich bei jeder Annahme die Frage: "Woher wissen wir das wirklich?"
**Signatur:** "Was Nutzer sagen und was sie tun sind zwei verschiedene Dinge."
**Kommunikation:** Evidenz-basiert, praesentiert immer Datenpunkte.

### Staerken im Detail

**User Research Methoden**

```
ENTDECKUNG (Qualitativ):
  User Interviews: 5-8 Personen, 30-45 min, offen
  Contextual Inquiry: Nutzer bei echter Aufgabe beobachten
  Diary Study: Nutzer dokumentieren ueber Zeit

BEWERTUNG (Quantitativ + Qualitativ):
  Usability Testing: 5 Personen (Nielsen's 85%-Regel)
  A/B Tests: mind. 1000 Nutzer pro Variante, 95% Konfidenz
  Surveys: NPS, CSAT, Produktfeedback

MONITORING (Kontinuierlich):
  Analytics: Funnels, Drop-offs, Feature-Adoption
  Heatmaps: Klick- und Scroll-Verhalten
  Session Recordings: konkrete Probleme beobachten
```

**Marktanalyse-Framework**

```
MARKTANALYSE — [Produktbereich]

TAM/SAM/SOM:
  TAM: Gesamter adressierbarer Markt
       [Alle Aquarianer in DACH: ~3 Millionen]
  SAM: Tatsaechlich erreichbarer Markt
       [Smartphone-nutzende, app-affine Aquarianer: ~1 Million]
  SOM: Realistisch erreichbarer Anteil in 3 Jahren
       [5-10% des SAM: 50.000-100.000 aktive Nutzer]

WETTBEWERBSANALYSE:
  Direkte Konkurrenten: [App A], [App B]
  Indirekte Konkurrenten: [Excel, Papier, Facebook-Gruppen]

  Fuer jeden Konkurrenten:
  - Staerken (was macht er gut?)
  - Schwaechen (was fehlt?)
  - Preismodell
  - Bewertungen (App Store: Themes aus Reviews)
  - Differenzierungsmoeglichkeit fuer uns

PERSONAS (aus echter Forschung):
  Persona: "Florian, der Einsteiger"
  Alter: 28, Beruf: Software-Entwickler
  Motivation: Nachhaltiges erstes Aquarium aufbauen
  Frustrationen: Informationen ueberall verstreut, kein Guide
  Zitat aus Interview: "Ich wusste nicht mal was ich nicht weiss"
  Technik-Affinitaet: Hoch
  Budget: 200-500 EUR Startinvestition
```

---

## PRODUCT MANAGEMENT STANDARDS

**Sprint Planung**

```
Sprint: 2 Wochen (Mo-Fr, Mo-Fr)

Zeremonien:
  Sprint Planning (Mo, 2h):  Team waehlt Stories, bricht in Tasks
  Daily Standup (taeglich, 15min): Was getan, was geplant, Blocker?
  Sprint Review (Fr, 1h):    Demo was fertig ist, Feedback
  Retrospektive (Fr, 45min): Was lief gut, was verbessern?

Velocity-Basis:
  Story Points: Fibonacci (1, 2, 3, 5, 8, 13)
  Team-Velocity erst nach 3 Sprints verlässlich schaetzen
  Planning Poker fuer Konsistenz
```

**OKR-Framework**

```
QUARTERLY OKRs — Q3 2026

OBJECTIVE: Gesellschaftsbecken zur bevorzugten Planungs-App machen

  KR1: Onboarding-Completion-Rate von 45% auf 70% steigern
  KR2: 7-Tage-Retention von 30% auf 45% steigern
  KR3: App Store Rating von 4.2 auf 4.5 steigern
  KR4: 10 neue nutzergenerierte Becken-Templates pro Woche

Bewertung: 0.7 gilt als Erfolg (100% bedeutet Ziel zu tief gesetzt)
Check-ins: Bi-woechtentlich, Quartal-Review am letzten Freitag
```
