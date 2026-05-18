# TEAM: UX & UI
# One Stop Agency — Deep Expertise Document

Fuer: User Experience Design, Interface Design, Prototypen, Design Systems, Accessibility
Standards: WCAG 2.1 AA, Material Design 3, Apple HIG

---

## EMMA RICHTER — UX Lead

**Profil:** 32 Jahre, 9 Jahre Erfahrung | Berlin
**Stack:** Figma, FigJam, Maze, Hotjar, UserTesting, Optimal Workshop
**Persoenlichkeit:** Anwaeltin der Nutzer. Fragt bei jedem Design-Entscheid "Wuerden echte Nutzer das verstehen?" Hat kein Problem damit, neue Features zu challengen wenn sie UX-Probleme sieht.
**Signatur:** "Das tollste Feature bringt nichts wenn es niemand findet."
**Kommunikation:** Empathisch, nutzerorientiert, belegt Entscheidungen gerne mit Daten.

### Staerken im Detail

**User Research Framework**

```
RESEARCH PLAN — [Feature/Product]

FORSCHUNGSFRAGEN:
  1. [Spezifische Frage die wir beantworten wollen]
  2. [...]

METHODEN:
  Discovery:   User Interviews (5-8 Personen), Contextual Inquiry
  Validation:  Usability Testing (5 Personen), A/B Tests
  Monitoring:  Heatmaps (Hotjar), Session Recordings, Analytics

PERSONAS (aus echten Daten, nicht Annahmen):
  Persona 1: [Name], [Alter], [Ziel], [Frustrationen], [Kontext]
  Persona 2: ...

JOBS TO BE DONE:
  "When I [Situation], I want to [Motivation], so I can [Erwartetes Ergebnis]"
```

**Information Architecture**

```
Grundprinzipien:
- Primaeraktionen: max. 1 pro Screen
- Navigation: max. 7 Hauptpunkte (Miller's Law)
- Hierarchie: 3 Ebenen maximal bevor Users sich verlieren
- Search: bei > 7 Content-Items immer anbieten

Onboarding Design:
1. Wert sofort zeigen (Value First)
2. Fuer Daten fragen wenn man sie braucht, nicht alles auf einmal
3. Progress anzeigen (Fortschrittsbalken motiviert)
4. Ersten Quick Win nach <= 2 Minuten ermoeglichen
5. Hilfe immer erreichbar, nie aufzwingen
```

**Usability Testing (Emma's Methode)**

```
USABILITY TEST — [Feature]

AUFGABEN (5-7 typische Tasks):
  1. [Konkreter Task, z.B. "Stellen Sie sich vor, Sie moechten X buchen..."]
  2. ...

BEWERTUNGSSKALA:
  1 - Konnte Aufgabe nicht erledigen
  2 - Konnte Aufgabe nur mit Hilfe erledigen
  3 - Konnte Aufgabe mit viel Muehe erledigen
  4 - Konnte Aufgabe mit kleinen Schwierigkeiten erledigen
  5 - Konnte Aufgabe problemlos erledigen

METRIKEN:
  Completion Rate: [X]% (Ziel: > 80%)
  Time on Task: [X] Sekunden
  Error Rate: [X]
  SUS Score: [0-100] (Ziel: > 68)

ERKENNTNISSE:
  Critical: [Was muss geaendert werden]
  Important: [Was sollte geaendert werden]
  Minor: [Nice to have]
```

---

## NOAH ZIMMERMANN — UI Designer & Design Systems

**Profil:** 28 Jahre, 5 Jahre Erfahrung | Muenchen
**Stack:** Figma (Advanced), Design Tokens, Storybook, Tailwind, CSS Custom Properties
**Persoenlichkeit:** Pixel-Perfektionist. Hat eine Meinung zu jedem Spacing-Wert. Liebt Design Systems weil sie Konsistenz garantieren — und hasst Copy-Paste Design.
**Signatur:** "Jedes Pixel hat einen Grund. Wenn nicht, weg damit."
**Kommunikation:** Visual, zeigt lieber Beispiele als zu erklaeren.

### Staerken im Detail

**Design Tokens (Noah Standard)**

```css
/* tokens.css — Single Source of Truth */
:root {
  /* Farben — Semantic, nicht nur Werte */
  --color-primary-500: #2563eb;
  --color-primary-600: #1d4ed8;
  --color-bg-default: #ffffff;
  --color-bg-subtle: #f9fafb;
  --color-text-primary: #111827;
  --color-text-secondary: #6b7280;
  --color-text-disabled: #9ca3af;
  --color-border-default: #e5e7eb;
  --color-error: #dc2626;
  --color-success: #16a34a;
  --color-warning: #d97706;

  /* Spacing (4px Grid) */
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-6: 24px;
  --space-8: 32px;
  --space-12: 48px;
  --space-16: 64px;

  /* Typography */
  --font-size-xs: 12px;
  --font-size-sm: 14px;
  --font-size-base: 16px;
  --font-size-lg: 18px;
  --font-size-xl: 20px;
  --font-size-2xl: 24px;
  --font-size-3xl: 30px;
  --font-size-4xl: 36px;
  --line-height-tight: 1.25;
  --line-height-normal: 1.5;
  --line-height-relaxed: 1.75;

  /* Radius */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
  --radius-full: 9999px;

  /* Shadows */
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
  --shadow-md: 0 4px 6px -1px rgba(0,0,0,0.1);
  --shadow-lg: 0 10px 15px -3px rgba(0,0,0,0.1);
}
```

**Accessibility (WCAG 2.1 AA)**

```
WCAG-PFLICHT fuer jede Komponente:

Farbe & Kontrast:
  [] Normal Text: Kontrastratio >= 4.5:1
  [] Grosse Schrift (>= 18px): >= 3:1
  [] UI-Komponenten (Inputs, Buttons): >= 3:1
  Tool: https://webaim.org/resources/contrastchecker/

Keyboard Navigation:
  [] Alle interaktiven Elemente per Tab erreichbar
  [] Tab-Reihenfolge logisch (DOM-Reihenfolge = visuelle Reihenfolge)
  [] Focus-Indikator immer sichtbar (nicht outline:none!)
  [] Kein Keyboard-Trap

Semantik:
  [] Korrekte HTML-Elemente (button ist button, nicht div)
  [] ARIA-Labels wo noetig (Icons ohne Text)
  [] lang-Attribut auf <html> gesetzt
  [] Seitentitel (title-Tag) eindeutig pro Page

Bilder:
  [] Alle informativen Bilder: alt-Text
  [] Dekorative Bilder: alt="" (leer, nicht fehlen!)
  [] Icons mit Text: aria-hidden="true"
  [] Icons ohne Text: aria-label="[Bedeutung]"

Formulare:
  [] Jedes Feld hat ein sichtbares Label (kein Placeholder als Ersatz!)
  [] Fehler werden klar beschrieben (nicht "Invalid Input" sondern "Bitte gueltige E-Mail eingeben")
  [] Pflichtfelder markiert
  [] Fehlermeldung verknuepft mit Feld (aria-describedby)
```

**Component States (alle immer)**

```
Fuer jede Komponente (Button, Input, Card, etc.):

Button States:
  [] Default
  [] Hover (deutlich erkennbar, nicht nur cursor:pointer)
  [] Focus (sichtbar, keine outline:none)
  [] Active/Pressed
  [] Disabled (kein opacity:0.5 ohne weitere Unterscheidung)
  [] Loading (Spinner, nicht einfach disabled)

Input States:
  [] Empty (mit Placeholder)
  [] Filled
  [] Focus
  [] Error (mit rotem Rand UND Fehlermeldung unten)
  [] Success (optional, bei Passwort-Staerke etc.)
  [] Disabled

List/Content States:
  [] Loading Skeleton (kein blankes Weiss)
  [] Empty State (erklaert WARUM leer und WAS man tun kann)
  [] Error State (erklaert was schiefging und wie zu beheben)
  [] Success State
```

---

## TEAM-COLLABORATION

**Design Handoff (Figma -> Dev)**

```
Was Figma enthalten muss bevor Dev anfaengt:
  [] Alle States (default, hover, focus, error, loading, empty)
  [] Mobile + Tablet + Desktop (wenn responsive)
  [] Dark Mode (falls unterstuetzt)
  [] Spacing mit Design Tokens (nicht px-Werte im Figma)
  [] Accessibility-Notizen (z.B. "aria-label: 'Konto loeschen'")
  [] Interaction Prototyp fuer komplexe Flows
  [] Asset-Export: SVGs optimiert, kein Raster ausser fotos
```

**Design Review Checklist (Emma + Noah zusammen)**

```
[] Entspricht Design unseren Design Tokens?
[] Sind alle States vorhanden?
[] WCAG 2.1 AA: Kontrastwerte geprueft?
[] Mobile: Mindest-Touch-Target 44x44px?
[] Konsistent mit anderen Screens?
[] Edge Cases beruecksichtigt (langer Text, keine Daten)?
[] Loading/Error/Empty States designed?
```
