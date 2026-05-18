#!/usr/bin/env bash
# scripts/validate.sh
# One Stop Agency — Repo-Integritaets-Validator
#
# Prueft, dass das Repo strukturell konsistent ist (CI-tauglich).
# Exit Code: 0 = OK, 1 = mind. ein Check fehlgeschlagen.
#
# Verwendung lokal:    bash scripts/validate.sh
# Verwendung in CI:    via .github/workflows/validate.yml

set -u

# Farben (deaktiviert wenn nicht TTY)
if [ -t 1 ]; then
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    YELLOW='\033[0;33m'
    CYAN='\033[0;36m'
    NC='\033[0m'
else
    GREEN=''; RED=''; YELLOW=''; CYAN=''; NC=''
fi

FAIL=0

check_ok()    { printf "${GREEN}OK${NC}   %s\n" "$1"; }
check_warn()  { printf "${YELLOW}WARN${NC} %s\n" "$1"; }
check_fail()  { printf "${RED}FAIL${NC} %s\n" "$1"; FAIL=$((FAIL + 1)); }
section()     { printf "\n${CYAN}== %s ==${NC}\n" "$1"; }

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "One Stop Agency — Repo Validator"
echo "Root: $ROOT"

# ---------------------------------------------------------------------------
section "Datei-Praesenz"

REQUIRED_TOPLEVEL=(
    "CLAUDE.md"
    "README.md"
    "LICENSE"
    "CHANGELOG.md"
    "update.ps1"
    "update.sh"
    "setup-project.ps1"
    "setup-project.sh"
)
for f in "${REQUIRED_TOPLEVEL[@]}"; do
    if [ -f "$f" ]; then check_ok "$f"; else check_fail "$f fehlt"; fi
done

# ---------------------------------------------------------------------------
section "Team-Dateien (sollten 14 sein)"

EXPECTED_TEAMS=(
    "development-qa"
    "infrastructure"
    "security"
    "compliance"
    "legal"
    "ux-ui"
    "graphic-design"
    "marketing-seo"
    "content-editorial"
    "product-management"
    "sales"
    "data-analytics"
    "finance"
    "customer-success"
)
COUNT=0
for team in "${EXPECTED_TEAMS[@]}"; do
    if [ -f "teams/${team}.md" ]; then
        check_ok "teams/${team}.md"
        COUNT=$((COUNT + 1))
    else
        check_fail "teams/${team}.md fehlt"
    fi
done
if [ "$COUNT" -eq 14 ]; then
    check_ok "14/14 Team-Dateien vorhanden"
else
    check_fail "Nur $COUNT/14 Team-Dateien gefunden"
fi

# Pruefe ob es mehr Team-Dateien gibt als erwartet
ACTUAL=$(find teams -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
if [ "$ACTUAL" -ne "$COUNT" ]; then
    check_warn "teams/ enthaelt $ACTUAL Markdown-Dateien, erwartet $COUNT — unbekannte Team-Datei?"
fi

# ---------------------------------------------------------------------------
section "Templates"

REQUIRED_TEMPLATES=(
    "templates/AI-PROVENANCE.md"
    "templates/ai-headers-snippets.md"
)
for f in "${REQUIRED_TEMPLATES[@]}"; do
    if [ -f "$f" ]; then check_ok "$f"; else check_fail "$f fehlt"; fi
done

# ---------------------------------------------------------------------------
section "Profile"

REQUIRED_PROFILES=(
    "profiles/saas-eu-b2b.json"
    "profiles/internal-tool.json"
    "profiles/mobile-app-only.json"
    "profiles/agency-client-work.json"
    "profiles/oss-library.json"
    "profiles/README.md"
)
for f in "${REQUIRED_PROFILES[@]}"; do
    if [ -f "$f" ]; then check_ok "$f"; else check_fail "$f fehlt"; fi
done

# JSON-Syntax pruefen falls jq da
if command -v jq >/dev/null 2>&1; then
    for f in profiles/*.json; do
        if jq empty "$f" 2>/dev/null; then
            check_ok "$f valid JSON"
        else
            check_fail "$f hat ungueltiges JSON"
        fi
    done
else
    check_warn "jq nicht verfuegbar — JSON-Syntax-Pruefung uebersprungen"
fi

# ---------------------------------------------------------------------------
section "Workflows"

REQUIRED_WORKFLOWS=(
    ".github/workflows/auto-update.yml"
    ".github/workflows/validate.yml"
    ".github/workflows/provenance-integrity.yml"
)
for f in "${REQUIRED_WORKFLOWS[@]}"; do
    if [ -f "$f" ]; then check_ok "$f"; else check_fail "$f fehlt"; fi
done

# ---------------------------------------------------------------------------
section "Sync-Konsistenz update-Scripts <-> teams/ + templates/"

# Alle Team-Dateien, die in update.ps1 referenziert sein muessen
MISSING_IN_PS=0
MISSING_IN_SH=0
for team in "${EXPECTED_TEAMS[@]}"; do
    if ! grep -q "teams/${team}.md" update.ps1 2>/dev/null; then
        check_fail "update.ps1 referenziert teams/${team}.md nicht"
        MISSING_IN_PS=$((MISSING_IN_PS + 1))
    fi
    if ! grep -q "teams/${team}.md" update.sh 2>/dev/null; then
        check_fail "update.sh referenziert teams/${team}.md nicht"
        MISSING_IN_SH=$((MISSING_IN_SH + 1))
    fi
done
[ "$MISSING_IN_PS" -eq 0 ] && check_ok "update.ps1: alle 14 Team-Files referenziert"
[ "$MISSING_IN_SH" -eq 0 ] && check_ok "update.sh:  alle 14 Team-Files referenziert"

# Templates auch
for t in "templates/AI-PROVENANCE.md" "templates/ai-headers-snippets.md"; do
    if ! grep -q "$t" update.ps1 2>/dev/null; then check_fail "update.ps1 referenziert $t nicht"; fi
    if ! grep -q "$t" update.sh  2>/dev/null; then check_fail "update.sh  referenziert $t nicht"; fi
done

# ---------------------------------------------------------------------------
section "Platzhalter (sollten alle ersetzt sein)"

PLACEHOLDERS=("DEIN-GITHUB-USERNAME" "DEIN-USERNAME/one-stop-agency")
# Self-Exclude: dieses Validator-Script enthaelt die Strings als Suchmuster.
# CHANGELOG.md zitiert sie ebenfalls (historisch). Beide werden ausgeschlossen.
EXCLUDE_FROM_PLACEHOLDER_SCAN=("scripts/validate.sh" "CHANGELOG.md")
for p in "${PLACEHOLDERS[@]}"; do
    HITS_RAW=$(grep -rIl --exclude-dir=.git --exclude-dir=node_modules "$p" . 2>/dev/null || true)
    HITS_FILTERED=""
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        SKIP=0
        for excl in "${EXCLUDE_FROM_PLACEHOLDER_SCAN[@]}"; do
            if [ "$line" = "./$excl" ] || [ "$line" = "$excl" ]; then SKIP=1; break; fi
        done
        [ "$SKIP" -eq 0 ] && HITS_FILTERED="${HITS_FILTERED}${line}"$'\n'
    done <<< "$HITS_RAW"
    HITS_FILTERED=$(printf "%s" "$HITS_FILTERED" | sed '/^$/d')
    if [ -n "$HITS_FILTERED" ]; then
        COUNT=$(printf "%s\n" "$HITS_FILTERED" | wc -l | tr -d ' ')
        check_fail "Platzhalter '$p' noch vorhanden in $COUNT Datei(en):"
        printf "%s\n" "$HITS_FILTERED" | sed 's/^/         /'
    else
        check_ok "Kein '$p' Platzhalter (ausser in self-exclude Liste)"
    fi
done

# Sonderfall: DEIN-USERNAME/DEIN-REPO ist erlaubt in README (als Beispiel fuer Fork-Nutzer),
# aber nicht in den Scripts selbst.
for script in update.ps1 update.sh setup-project.ps1 setup-project.sh; do
    if grep -E "https://[^\"' ]*DEIN-USERNAME[^\"' ]*" "$script" >/dev/null 2>&1; then
        # Nur fehlerhaft wenn nicht im Kommentar (-> Hinweistext fuer Fork-Nutzer ist OK)
        # Heuristik: wenn in echter URL-Zuweisung (param-Default), ist es ein Fehler
        if grep -E "^\s*\[string\]\\\$RepoUrl\s*=\s*\"https://[^\"]*DEIN-USERNAME" "$script" >/dev/null 2>&1 \
           || grep -E "^REPO_URL=\"https://[^\"]*DEIN-USERNAME" "$script" >/dev/null 2>&1; then
            check_fail "$script: DEIN-USERNAME in produktivem URL-Default — sollte mtmatefi sein"
        fi
    fi
done

# ---------------------------------------------------------------------------
section "Markdown-Hygiene"

# Pruefe ob jedes Team-File einen Header hat
for team in "${EXPECTED_TEAMS[@]}"; do
    if ! head -1 "teams/${team}.md" 2>/dev/null | grep -q "^# TEAM:"; then
        check_warn "teams/${team}.md hat keinen '# TEAM:'-Header in Zeile 1"
    fi
done
check_ok "Team-Header gepruegen (siehe WARN oben falls Abweichung)"

# ---------------------------------------------------------------------------
section "Ergebnis"

if [ "$FAIL" -eq 0 ]; then
    printf "${GREEN}All checks passed.${NC}\n"
    exit 0
else
    printf "${RED}%d Check(s) fehlgeschlagen.${NC}\n" "$FAIL"
    exit 1
fi
