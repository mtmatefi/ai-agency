<!-- @ai-assisted: claude-opus-4-8 via One-Stop-Agency / <Persona> -->
<!-- @ai-date: YYYY-MM-DD -->
<!-- @ai-task: Mandanten-Standards-Overlay (Delta zur Basis) -->
<!-- @human-review: OFFEN -->

# Standards — <KUNDE>

> NUR Deltas zur Basis (`CLAUDE.md` + `teams/`). Was hier nicht steht, gilt wie
> in der Engine. **Override-Floor:** Verschaerfen erlaubt, Absenken unter das
> Engine-Minimum NICHT (Validator + CLAUDE.md MANDANTEN-MODUS erzwingen das).

## Wirkt auf
Dev/QA (Lucas, Sarah, Finn, Nina), Security (Marco, Zara), Compliance (Elena, Thomas).

## Verschaerfungen (Beispiele — anpassen oder loeschen)

| Thema | Engine-Default | Bei <KUNDE> |
|-------|----------------|-------------|
| Test-Coverage | >= 80% | <z.B. >= 90%> |
| OWASP ASVS | L2 | <z.B. L3> |
| Code-Review | 1 Reviewer | <z.B. 2 Reviewer, davon 1 Security> |
| Branch-Strategie | trunk/feature | <kundenspezifisch> |

## Kundenspezifische Pflicht-Checks
- <z.B. zusaetzliche Regulierung / interne Policy / Audit-Anforderung>

## Was NICHT abgesenkt werden darf (Erinnerung)
AI-Provenance, Recherche-Pflicht, ASVS L2, Coverage 80%, DSGVO, WCAG 2.1 AA.
