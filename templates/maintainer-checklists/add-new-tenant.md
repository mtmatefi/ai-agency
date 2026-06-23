<!-- @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Agency Director -->
<!-- @ai-date: 2026-06-23 -->
<!-- @ai-task: Maintainer-Checkliste fuer neuen Mandanten -->
<!-- @human-review: OFFEN -->

# Checkliste: Neuen Mandanten (Kunde) anlegen

Ziel: ein neues privates Overlay-Repo `agency-tenant-<kunde>` aufsetzen und in
einem Projekt aktivieren. Konzept: `tenants/README.md`. Schema: `CLAUDE.md` ->
`MANDANTEN-MODUS`.

> Wichtig: Mandanten-Overlays leben NICHT im Engine-Repo (mtmatefi/ai-agency),
> sondern in einem eigenen, PRIVATEN Repo pro Kunde (Vertraulichkeit). Im
> Engine-Repo aenderst du beim Anlegen eines Kunden in der Regel NICHTS.

## Werte abfragen
- [ ] Kunden-Slug (kebab-case, z.B. `pilatus`)
- [ ] Anzeigename
- [ ] Default-Profil (eines aus `profiles/`)
- [ ] Sprache(n)
- [ ] Standards-Verschaerfungen? (Coverage, ASVS-Level, Review-Regeln)
- [ ] Design-Tokens (Farben, Fonts, Spacing) — vom Kunden besorgen
- [ ] UX: Ziel-Personas, Segmente, Tonalitaet
- [ ] Brand-Voice: Anrede, bevorzugte/verbotene Begriffe

## Repo erstellen
- [ ] Privates Repo `agency-tenant-<kunde>` anlegen (Zugriff nur fuer Berechtigte)
- [ ] Inhalt aus `templates/tenant-template/` kopieren (inkl. `.github/workflows/`)
- [ ] `config.json` ausfuellen: `name`, `display_name`, `engine_min` (aktuelle
      Engine-Version), `default_profile`, `languages`, `standards_overrides`, `sign_off`
- [ ] `standards.md`, `design-system.md`, `ux.md`, `brand-voice.md` mit Kunden-Deltas fuellen
- [ ] ALLE Platzhalter ersetzen (`<KUNDE>`, `TENANT-SLUG`, `Kunde Anzeigename`)

## Override-Floor pruefen (Pflicht)
- [ ] `min_coverage` >= 80
- [ ] `owasp_asvs_level` in {L2, L3}
- [ ] keine Absenkung von DSGVO / WCAG 2.1 AA / AI-Provenance / Recherche-Pflicht
- [ ] `bash scripts/validate-tenant.sh <pfad>` -> gruen
      (oder CI im Mandanten-Repo abwarten — `validate-tenant.yml`)

## Im Projekt aktivieren
- [ ] `.agency/config.json` des Kundenprojekts um `tenant` + `tenant_repo`
      (+ optional `tenant_pin`) ergaenzen
- [ ] `bash update.sh` / `.\update.ps1` -> Overlay landet in `.agency/tenant/`
- [ ] Smoke-Test: eine kunden-sichtbare Aufgabe stellen, pruefen ob Claude die
      Tokens/Personas aus dem Overlay anwendet

## Abschluss (nur falls du DOCH am Engine-Repo etwas geaendert hast)
- [ ] `bash scripts/validate.sh` gruen
- [ ] CHANGELOG-Eintrag
- [ ] AI-PROVENANCE.md-Eintrag
- [ ] Co-Authored-By im Commit

> In den meisten Faellen ist "neuer Kunde" eine reine Mandanten-Repo-Operation —
> dann faellt der Engine-Abschluss-Block weg.
