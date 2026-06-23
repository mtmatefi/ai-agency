#!/usr/bin/env bash
# scripts/validate-tenant.sh
# One Stop Agency — Mandanten-Overlay-Validator
#
# Prueft ein Mandanten-Overlay (agency-tenant-<kunde>) auf Schema-Konformitaet
# und Override-Floor. Laeuft lokal UND in der CI des Mandanten-Repos (das die
# Datei aus der Engine zieht — DRY).
#
# Verwendung:  bash scripts/validate-tenant.sh [pfad-zum-overlay]   (default: .)
# Exit: 0 = OK, 1 = mind. ein FAIL.
#
# @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Kai Bauer (DevOps) + Marco Reiter (Floor)
# @ai-date: 2026-06-23
# @ai-task: Validator fuer Mandanten-Overlays inkl. Override-Floor
# @human-review: OFFEN bis mtmatefi Sign-Off

set -u

if [ -t 1 ]; then
    GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'; CYAN='\033[0;36m'; NC='\033[0m'
else
    GREEN=''; RED=''; YELLOW=''; CYAN=''; NC=''
fi

FAIL=0
check_ok()   { printf "${GREEN}OK${NC}   %s\n" "$1"; }
check_warn() { printf "${YELLOW}WARN${NC} %s\n" "$1"; }
check_fail() { printf "${RED}FAIL${NC} %s\n" "$1"; FAIL=$((FAIL + 1)); }
section()    { printf "\n${CYAN}== %s ==${NC}\n" "$1"; }

DIR="${1:-.}"
cd "$DIR" || { echo "Verzeichnis nicht gefunden: $DIR"; exit 1; }

echo "One Stop Agency — Tenant Overlay Validator"
echo "Overlay: $(pwd)"

# ---------------------------------------------------------------------------
section "Pflicht-Dateien"

REQUIRED=("config.json" "standards.md" "design-system.md" "ux.md" "brand-voice.md")
for f in "${REQUIRED[@]}"; do
    if [ -f "$f" ]; then check_ok "$f"; else check_fail "$f fehlt"; fi
done

# ---------------------------------------------------------------------------
section "config.json — Schema"

if [ ! -f config.json ]; then
    check_fail "config.json fehlt — Schema-Check uebersprungen"
else
    if command -v jq >/dev/null 2>&1; then
        if jq empty config.json 2>/dev/null; then
            check_ok "config.json valid JSON"
        else
            check_fail "config.json ungueltiges JSON"
        fi
        for key in name engine_min default_profile; do
            VAL=$(jq -r ".${key} // empty" config.json 2>/dev/null)
            if [ -n "$VAL" ]; then check_ok "config.json hat '$key' ($VAL)"; else check_fail "config.json: Pflicht-Feld '$key' fehlt/leer"; fi
        done
    else
        check_warn "jq nicht verfuegbar — JSON-Schema-Check eingeschraenkt"
        for key in '"name"' '"engine_min"' '"default_profile"'; do
            if grep -q "$key" config.json; then check_ok "config.json enthaelt $key"; else check_fail "config.json: $key fehlt"; fi
        done
    fi
fi

# ---------------------------------------------------------------------------
section "Override-Floor (Mandant darf nur verschaerfen)"

# Strukturierte Checks aus config.json (wenn jq da)
if command -v jq >/dev/null 2>&1 && [ -f config.json ]; then
    COV=$(jq -r '.standards_overrides.min_coverage // empty' config.json 2>/dev/null)
    ASVS=$(jq -r '.standards_overrides.owasp_asvs_level // empty' config.json 2>/dev/null)
    if [ -n "$COV" ]; then
        if [ "$COV" -lt 80 ] 2>/dev/null; then
            check_fail "min_coverage=$COV unterschreitet Engine-Floor 80%"
        else
            check_ok "min_coverage=$COV (>= 80)"
        fi
    fi
    if [ -n "$ASVS" ]; then
        case "$ASVS" in
            L1) check_fail "owasp_asvs_level=L1 unterschreitet Engine-Floor L2" ;;
            L2|L3) check_ok "owasp_asvs_level=$ASVS (>= L2)" ;;
            *) check_warn "owasp_asvs_level='$ASVS' unbekannt (erwartet L2/L3)" ;;
        esac
    fi
fi

# Heuristische Text-Checks in standards.md (faengt offensichtliche Absenkungen)
if [ -f standards.md ]; then
    if grep -iEq "coverage[^0-9]*(<|unter|below)[^0-9]*([0-7][0-9]|[0-9])[^0-9]" standards.md; then
        check_warn "standards.md erwaehnt evtl. Coverage < 80 — manuell pruefen"
    fi
    if grep -iEq "asvs[^a-z]*l1" standards.md; then
        check_warn "standards.md erwaehnt ASVS L1 — Floor ist L2, manuell pruefen"
    fi
    check_ok "standards.md Heuristik-Scan durchgefuehrt"
fi

# ---------------------------------------------------------------------------
section "Hygiene (keine Template-Platzhalter mehr)"

PLACEHOLDERS=("TENANT-SLUG" "<KUNDE>" "Kunde Anzeigename")
for p in "${PLACEHOLDERS[@]}"; do
    HITS=$(grep -rIl --exclude-dir=.git "$p" . 2>/dev/null || true)
    if [ -n "$HITS" ]; then
        check_warn "Platzhalter '$p' noch vorhanden:"
        printf "%s\n" "$HITS" | sed 's/^/         /'
    else
        check_ok "kein '$p' Platzhalter"
    fi
done

# ---------------------------------------------------------------------------
section "Ergebnis"

if [ "$FAIL" -eq 0 ]; then
    printf "${GREEN}Tenant overlay OK.${NC}\n"
    exit 0
else
    printf "${RED}%d Check(s) fehlgeschlagen.${NC}\n" "$FAIL"
    exit 1
fi
