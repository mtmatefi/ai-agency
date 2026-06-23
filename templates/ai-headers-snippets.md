# AI-Header & Block-Marker — Snippets pro Sprache

Copy-paste-Vorlagen fuer die im `CLAUDE.md`-Protokoll geforderten
**Ebene A (Datei-Header)** und **Ebene B (Block-Marker)**.

Heute eingesetzes Modell: `claude-opus-4-8 (1M context)`.
Persona ist die Rolle aus One-Stop-Agency, die den Code "verantwortet"
(z.B. "Lucas Keller", "Sarah Wagner", "Finn Meyer").

---

## TypeScript / JavaScript

```typescript
/**
 * <1-Satz-Zweck der Datei>
 *
 * @ai-assisted: claude-opus-4-8 via One-Stop-Agency / <Persona>
 * @ai-date: YYYY-MM-DD
 * @ai-task: <kurze Beschreibung>
 * @human-review: <Name oder OFFEN>, <Datum oder OFFEN>
 */

// Block-Marker fuer AI-generierte Sektion in existierender Datei:
// @ai-block:start (claude-opus-4-8 / <Persona>, YYYY-MM-DD)
// purpose: <was tut der Block>
...
// @ai-block:end
```

---

## PHP (Laravel)

```php
<?php
/**
 * <1-Satz-Zweck der Datei>
 *
 * @ai-assisted claude-opus-4-8 via One-Stop-Agency / <Persona>
 * @ai-date    YYYY-MM-DD
 * @ai-task    <kurze Beschreibung>
 * @human-review <Name oder OFFEN>, <Datum oder OFFEN>
 */

// Block-Marker:
// @ai-block:start (claude-opus-4-8 / <Persona>, YYYY-MM-DD)
// purpose: <was tut der Block>
...
// @ai-block:end
```

---

## Kotlin / Java (Android)

```kotlin
/**
 * <1-Satz-Zweck der Datei>
 *
 * @ai-assisted claude-opus-4-8 via One-Stop-Agency / <Persona>
 * @ai-date YYYY-MM-DD
 * @ai-task <kurze Beschreibung>
 * @human-review <Name oder OFFEN>, <Datum oder OFFEN>
 */

// @ai-block:start (claude-opus-4-8 / <Persona>, YYYY-MM-DD)
// purpose: <was tut der Block>
...
// @ai-block:end
```

---

## Python

```python
"""<1-Satz-Zweck der Datei>.

@ai-assisted: claude-opus-4-8 via One-Stop-Agency / <Persona>
@ai-date: YYYY-MM-DD
@ai-task: <kurze Beschreibung>
@human-review: <Name oder OFFEN>, <Datum oder OFFEN>
"""

# @ai-block:start (claude-opus-4-8 / <Persona>, YYYY-MM-DD)
# purpose: <was tut der Block>
...
# @ai-block:end
```

---

## YAML / JSON / SQL / TOML

```yaml
# @ai-assisted: claude-opus-4-8 via One-Stop-Agency / <Persona>
# @ai-date:     YYYY-MM-DD
# @ai-task:     <kurze Beschreibung>
# @human-review: <Name oder OFFEN>, <Datum oder OFFEN>
```

JSON kennt keine Kommentare — daher entweder JSONC (`// @ai-assisted: ...`),
oder Begleit-Datei `<filename>.ai-provenance.md`, oder Eintrag in `AI-PROVENANCE.md`.

---

## Markdown

```markdown
<!-- @ai-assisted: claude-opus-4-8 via One-Stop-Agency / <Persona>
     @ai-date: YYYY-MM-DD
     @ai-task: <kurze Beschreibung>
     @human-review: <Name oder OFFEN>, <Datum oder OFFEN> -->
```

---

## SQL-Migration

```sql
-- @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Sarah Wagner
-- @ai-date:     YYYY-MM-DD
-- @ai-task:     <Migrations-Zweck>
-- @human-review: <Name oder OFFEN>
-- @rollback:    <Rollback-Hinweis oder Reference>
```

---

## Shell / PowerShell

```bash
#!/usr/bin/env bash
# @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Kai Bauer
# @ai-date:     YYYY-MM-DD
# @ai-task:     <Script-Zweck>
# @human-review: <Name oder OFFEN>
```

```powershell
# @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Kai Bauer
# @ai-date:     YYYY-MM-DD
# @ai-task:     <Script-Zweck>
# @human-review: <Name oder OFFEN>
```

---

## Wann KEIN Marker noetig

- Trivial-Aenderungen (< 5 Zeilen Mechanik wie Rename, Typo, Lint-Auto-Fix)
- Komplett von Mensch geschriebener Code
- Generated Code von nicht-AI-Tools (z.B. `prisma generate`, `tsc -d`, OpenAPI codegen)
  -> diese tragen idR. einen Tool-spezifischen "DO NOT EDIT"-Kommentar und brauchen
     keinen zusaetzlichen AI-Marker
