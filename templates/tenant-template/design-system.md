<!-- @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Noah Zimmermann -->
<!-- @ai-date: YYYY-MM-DD -->
<!-- @ai-task: Mandanten-Design-System-Overlay -->
<!-- @human-review: OFFEN -->

# Design-System — <KUNDE>

> Wirkt auf Noah (UI), Lea (Brand), Felix (Creative Direction). Diese Tokens
> ueberschreiben generische Defaults bei JEDER kunden-sichtbaren UI-Arbeit.

## Brand-Farben (Design Tokens)

| Token | Wert | Verwendung |
|-------|------|------------|
| `--color-primary`   | `#______` | Primaer-Aktionen, Links |
| `--color-secondary` | `#______` | Sekundaer |
| `--color-accent`    | `#______` | Highlights |
| `--color-bg`        | `#______` | Hintergrund |
| `--color-fg`        | `#______` | Text |
| `--color-error`     | `#______` | Fehlerzustaende |

Kontrast: alle Text/BG-Kombis muessen WCAG 2.1 AA (>= 4.5:1) erfuellen.

## Typografie
- Headings: `<Font>`, Gewichte `<...>`
- Body: `<Font>`, Basisgroesse `16px`
- Mono: `<Font>`

## Spacing & Radius
- Spacing-Skala: `4 / 8 / 12 / 16 / 24 / 32 / 48`
- Border-Radius: `<z.B. 8px>`

## Komponenten-Bibliothek
- Basis: `<z.B. shadcn/ui + Tailwind>` (Engine-Default)
- Kundenspezifische Komponenten / Abweichungen: `<...>`

## Do / Don't
- DO: <z.B. viel Whitespace, klare Hierarchie>
- DON'T: <z.B. keine Schlagschatten, kein Pure-Black #000>

## Logo / Assets
- Speicherort: `<URL / Pfad im Mandanten-Repo>`
- Schutzraum, Mindestgroesse, erlaubte Varianten: `<...>`
