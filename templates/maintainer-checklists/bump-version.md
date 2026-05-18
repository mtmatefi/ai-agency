# Checkliste: Versions-Bump

Wizard fuer `/agency bump <major|minor|patch>`.

## Schritt 1 — Aktuellen Stand erfassen

```bash
# Letzte Version aus CHANGELOG.md (erster Eintrag unter ## [X.Y.Z])
LAST_VERSION=$(grep -oE '^## \[[0-9]+\.[0-9]+\.[0-9]+\]' CHANGELOG.md | head -1 | tr -d '[]## ')

# Bumpe nach semver
MAJOR_BUMP=...
MINOR_BUMP=...
PATCH_BUMP=...
```

## Schritt 2 — Commits seit letzter Version

```bash
git log "v${LAST_VERSION}..HEAD" --oneline  # falls Tag existiert
# oder: git log "${LAST_RELEASE_COMMIT}..HEAD" --oneline
```

Klassifiziere jeden Commit:
- `feat:` → Hinzugefuegt
- `fix:` → Behoben
- `chore:`, `refactor:`, `docs:` → Geaendert
- `security:` → Sicherheit
- BREAKING CHANGE im Body → Geaendert (BREAKING)

## Schritt 3 — CHANGELOG.md erweitern

Neuer Block UEBER der letzten Version:

```
## [<NEW_VERSION>] - YYYY-MM-DD

### Hinzugefuegt
- ...

### Geaendert
- ...

### Behoben
- ...

### Sicherheit
- ...
```

WICHTIG: Append-only-Prinzip — bestehende Eintraege NICHT aendern.

## Schritt 4 — AI-PROVENANCE.md Eintrag

Anfuegen UEBER `<!-- AI-PROVENANCE-LOG-END -->`:

```
## YYYY-MM-DD — v<NEW_VERSION> Release

Files:
  - CHANGELOG.md (MODIFIED, +v<NEW_VERSION>-Block)
  - CLAUDE.md (MODIFIED, Version-String im Footer)
  - README.md (MODIFIED, Version-String im Footer)
  - AI-PROVENANCE.md (MODIFIED, +dieser Eintrag)

Model:    claude-opus-4-7 (1M context)
Persona:  Tech Writer (Ben) + DevOps (Kai)
Reviewer: OFFEN
Task:     Versions-Bump auf v<NEW_VERSION>. Konsolidiert N Commits seit v<LAST>.
Notes:    <kurze Zusammenfassung was in dieser Version drin ist>
Commit:   (dieser Commit)
```

## Schritt 5 — Footer-Updates

In CLAUDE.md und README.md den Versions-Footer aktualisieren:

```
Agency Version: <NEW_VERSION> | Stand: YYYY-MM-DD (...)
```

## Schritt 6 — Validator

```bash
bash scripts/validate.sh
```

## Schritt 7 — Commit-Vorschlag

```
chore(release): v<NEW_VERSION>

<3-Zeilen-Highlight, was diese Version bringt>

Siehe CHANGELOG.md fuer vollstaendige Liste.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
```

## Schritt 8 — Tag-Vorschlag

```bash
git tag -a "v<NEW_VERSION>" -m "Release v<NEW_VERSION>"
git push origin "v<NEW_VERSION>"   # nur nach User-OK
```

## Schritt 9 — GitHub Release (optional, manuell)

`gh release create v<NEW_VERSION> --notes-from-tag` — User entscheiden lassen ob das gewuenscht ist.
