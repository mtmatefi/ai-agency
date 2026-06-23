<!-- @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Ben Fischer -->
<!-- @ai-date: 2026-06-23 -->
<!-- @ai-task: README fuer ein Mandanten-Overlay-Repo (Template) -->
<!-- @human-review: OFFEN -->

# agency-tenant-<KUNDE>

Privates Mandanten-Overlay fuer **<KUNDE>**. Enthaelt NUR die Deltas zur
geteilten Engine (`mtmatefi/ai-agency`): Standards, Design-System, UX, Brand-Voice.

> Architektur + Update-Flow: siehe `tenants/README.md` im Engine-Repo.

## Struktur

```
config.json        Meta (name, engine_min, default_profile, sign_off)
standards.md       Verschaerfte Standards -> Dev/QA/Security/Compliance
design-system.md   Tokens, Komponenten, Do/Don't -> Noah/Lea/Felix
ux.md              Personas, Segmente, Tonalitaet -> Emma/Anna
brand-voice.md     Schreibstil -> Amelie/Ben
.github/workflows/validate-tenant.yml   CI: zieht validate-tenant.sh aus der Engine
```

## Regeln

- **Nur Deltas.** Niemals Teams kopieren. Was nicht abweicht, kommt aus der Engine.
- **Override-Floor.** Standards nur verschaerfen, nie unter Engine-Minimum absenken
  (ASVS L2, Coverage 80%, DSGVO, WCAG 2.1 AA, AI-Provenance, Recherche-Pflicht).
  Der Validator (`validate-tenant.sh`) blockt Verstoesse.
- **Vertraulich.** Dieses Repo enthaelt Kundengeheimnisse. Privat halten,
  Zugriff nur fuer Berechtigte.

## In einem Projekt aktivieren

`.agency/config.json` des Kundenprojekts:

```json
{
  "profile": "<default_profile aus config.json>",
  "tenant": "<KUNDE>",
  "tenant_repo": "https://raw.githubusercontent.com/<org>/agency-tenant-<KUNDE>/main",
  "tenant_pin": null
}
```

Dann `bash update.sh` (oder `.\update.ps1`) — zieht Engine + dieses Overlay.

## Lokal validieren

```bash
curl -fsSL https://raw.githubusercontent.com/mtmatefi/ai-agency/main/scripts/validate-tenant.sh -o /tmp/vt.sh
bash /tmp/vt.sh .
```
