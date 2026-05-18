# AI Provenance Log

Append-only-Verzeichnis aller AI-assistierten Aenderungen an diesem Projekt.

Pflicht laut `CLAUDE.md` (One-Stop-Agency) — Abschnitt
"AI-CODE-DOKUMENTATIONS-PROTOKOLL".

**Regeln:**
- NICHT loeschen, NICHT umstrukturieren — nur unten anfuegen.
- Pro Session/PR ein Eintrag (nicht pro Datei).
- Reviewer-Feld wird bei Sign-Off gefuellt (vorher: `OFFEN`).
- Bei Audit (CRA, AI Act, ISO 27001): diese Datei + zugehoerige Commits sind der Trail.

**Format pro Eintrag:**

```
## YYYY-MM-DD — <kurzer Titel der Aenderung>

Files:
  - path/to/file.ext (NEW, full AI-generated)
  - path/to/other.ext (MODIFIED, ai-block lines 42-87)

Model:    claude-opus-4-7 (1M context)
Persona:  <Persona-Name> (<Team>) via One-Stop-Agency
Reviewer: <git user / "OFFEN bis Sign-Off">
Task:     <Beschreibung der Aufgabe>
Notes:    <Hinweise, z.B. ausstehende Sign-Offs, Test-Coverage, Limitationen>
```

---

<!-- AI-PROVENANCE-LOG-START -->

## 2026-MM-DD — Beispiel-Eintrag (loeschen sobald echter Eintrag vorhanden)

Files:
  - src/example.ts (NEW, full AI-generated)

Model:    claude-opus-4-7 (1M context)
Persona:  Lucas Keller (Development & QA) via One-Stop-Agency
Reviewer: OFFEN
Task:     Demo-Eintrag, Format-Vorlage
Notes:    Dieser Eintrag ist Platzhalter. Beim ersten echten Eintrag den
          Beispiel-Block entfernen.

<!-- AI-PROVENANCE-LOG-END -->
