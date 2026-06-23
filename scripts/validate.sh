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
    "GOVERNANCE.md"
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
    "templates/githooks/pre-commit"
    "templates/maintainer-checklists/add-new-team.md"
    "templates/maintainer-checklists/add-new-profile.md"
    "templates/maintainer-checklists/add-new-regulation.md"
    "templates/maintainer-checklists/bump-version.md"
)
for f in "${REQUIRED_TEMPLATES[@]}"; do
    if [ -f "$f" ]; then check_ok "$f"; else check_fail "$f fehlt"; fi
done

# ---------------------------------------------------------------------------
section "Skills"

REQUIRED_SKILLS=(
    ".claude/skills/agency.md"
)
for f in "${REQUIRED_SKILLS[@]}"; do
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
check_ok "Team-Header geprueft (siehe WARN oben falls Abweichung)"

# ---------------------------------------------------------------------------
section "Versions-Konsistenz (Footer == CHANGELOG)"

CLAUDE_VER=$(grep -oE "Agency Version: [0-9]+\.[0-9]+\.[0-9]+" CLAUDE.md 2>/dev/null | head -1 | grep -oE "[0-9]+\.[0-9]+\.[0-9]+" || true)
README_VER=$(grep -oE "Version: [0-9]+\.[0-9]+\.[0-9]+" README.md 2>/dev/null | head -1 | grep -oE "[0-9]+\.[0-9]+\.[0-9]+" || true)
CHANGELOG_VER=$(grep -oE "^## \[[0-9]+\.[0-9]+\.[0-9]+\]" CHANGELOG.md 2>/dev/null | head -1 | grep -oE "[0-9]+\.[0-9]+\.[0-9]+" || true)

if [ -z "$CHANGELOG_VER" ]; then
    check_fail "Keine Version in CHANGELOG.md gefunden (erwartet '## [X.Y.Z]')"
else
    check_ok "CHANGELOG-Top-Version: $CHANGELOG_VER"
fi
if [ -n "$CLAUDE_VER" ] && [ "$CLAUDE_VER" = "$CHANGELOG_VER" ]; then
    check_ok "CLAUDE.md Footer-Version stimmt ($CLAUDE_VER)"
else
    check_fail "CLAUDE.md Footer-Version '$CLAUDE_VER' != CHANGELOG '$CHANGELOG_VER'"
fi
if [ -n "$README_VER" ] && [ "$README_VER" = "$CHANGELOG_VER" ]; then
    check_ok "README.md Footer-Version stimmt ($README_VER)"
else
    check_fail "README.md Footer-Version '$README_VER' != CHANGELOG '$CHANGELOG_VER'"
fi

# ---------------------------------------------------------------------------
section "Auto-Update-Stempel (einzige vom Workflow gebumpte Zeile)"

for f in CLAUDE.md README.md; do
    if grep -qE "Auto-Update-Stempel: 20[0-9]{2}-[0-9]{2}-[0-9]{2}" "$f" 2>/dev/null; then
        check_ok "$f hat 'Auto-Update-Stempel'-Token"
    else
        check_fail "$f fehlt 'Auto-Update-Stempel: YYYY-MM-DD' — Auto-Update-Workflow haette kein Ziel"
    fi
done

# ---------------------------------------------------------------------------
section "Modell-Versions-Konsistenz (forward-looking)"

# Live-Logs sind historisch und duerfen alte Modell-IDs nennen -> ausgeschlossen.
FW_FILES=$(grep -rlE "opus-4-[0-9]+" --include="*.md" . 2>/dev/null | grep -vE "(AI-PROVENANCE\.md|CHANGELOG\.md)" || true)
FW_MODELS=""
while IFS= read -r file; do
    [ -z "$file" ] && continue
    M=$(grep -hoE "opus-4-[0-9]+" "$file" 2>/dev/null)
    FW_MODELS="${FW_MODELS}${M}"$'\n'
done <<< "$FW_FILES"
FW_MODELS=$(printf "%s\n" "$FW_MODELS" | sed '/^$/d' | sort -u)
DISTINCT=$(printf "%s" "$FW_MODELS" | grep -c . || true)
if [ "$DISTINCT" -le 1 ]; then
    check_ok "Einheitliche Modell-Referenz: $(printf "%s" "$FW_MODELS" | tr '\n' ' ')"
else
    check_fail "Uneinheitliche Modell-Referenzen in forward-looking Dateien:"
    printf "%s\n" "$FW_MODELS" | sed 's/^/         /'
    echo "         -> alle nicht-historischen Dateien muessen dieselbe opus-4-x-ID nennen."
fi

# ---------------------------------------------------------------------------
section "Profil -> Team referenzielle Integritaet"

PROFILE_FAIL=0
for pf in profiles/*.json; do
    [ -f "$pf" ] || continue
    TEAMS_IN_PROFILE=$(awk '
        /"teams"[[:space:]]*:/ { inteams=1 }
        inteams {
            line=$0
            while (match(line, /"[a-z0-9-]+"/)) {
                s=substr(line, RSTART+1, RLENGTH-2)
                if (s != "teams") print s
                line=substr(line, RSTART+RLENGTH)
            }
            if (index($0, "]") > 0) inteams=0
        }
    ' "$pf")
    for t in $TEAMS_IN_PROFILE; do
        if [ ! -f "teams/${t}.md" ]; then
            check_fail "$pf referenziert teams/${t}.md — existiert nicht"
            PROFILE_FAIL=$((PROFILE_FAIL + 1))
        fi
    done
done
[ "$PROFILE_FAIL" -eq 0 ] && check_ok "Alle Profile referenzieren existierende Team-Files"

# ---------------------------------------------------------------------------
section "Git-Hooks (lokale Selbstheilung)"

for f in "scripts/install-githooks.sh" ".githooks/pre-commit"; do
    if [ -f "$f" ]; then check_ok "$f"; else check_fail "$f fehlt"; fi
done

# ---------------------------------------------------------------------------
section "Dokumentation"

if [ -f docs/HANDBOOK.md ]; then
    check_ok "docs/HANDBOOK.md vorhanden"
else
    check_fail "docs/HANDBOOK.md fehlt"
fi
if grep -q "docs/HANDBOOK.md" README.md 2>/dev/null; then
    check_ok "README.md verlinkt das Handbuch"
else
    check_fail "README.md verlinkt docs/HANDBOOK.md nicht"
fi

# ---------------------------------------------------------------------------
section "Governance (Zero Trust)"

if [ -f GOVERNANCE.md ]; then
    check_ok "GOVERNANCE.md vorhanden"
    # Verfassung muss die Kern-Sektionen + §13-Config-Block haben
    for marker in "Zero Trust Governance" "The Three Lanes" "default_lane"; do
        if grep -q "$marker" GOVERNANCE.md 2>/dev/null; then
            check_ok "GOVERNANCE.md enthaelt '$marker'"
        else
            check_fail "GOVERNANCE.md fehlt '$marker'"
        fi
    done
else
    check_fail "GOVERNANCE.md fehlt"
fi

# CLAUDE.md muss Governance als hoechste Praezedenz verdrahten
if grep -q "GOVERNANCE GEHT VOR" CLAUDE.md 2>/dev/null && grep -q "GOVERNANCE.md" CLAUDE.md 2>/dev/null; then
    check_ok "CLAUDE.md verdrahtet GOVERNANCE.md (hoechste Praezedenz)"
else
    check_fail "CLAUDE.md verweist nicht auf GOVERNANCE.md als hoechste Praezedenz"
fi

# update-Scripts muessen GOVERNANCE.md mit-syncen (wandert in jedes Projekt)
for s in update.sh update.ps1; do
    if grep -q "GOVERNANCE.md" "$s" 2>/dev/null; then
        check_ok "$s synct GOVERNANCE.md ins Projekt"
    else
        check_fail "$s synct GOVERNANCE.md nicht"
    fi
done

# ---------------------------------------------------------------------------
section "Mandantenfaehigkeit (Multi-Tenancy)"

TENANT_REQUIRED=(
    "scripts/validate-tenant.sh"
    "tenants/README.md"
    "templates/maintainer-checklists/add-new-tenant.md"
    "templates/tenant-template/config.json"
    "templates/tenant-template/standards.md"
    "templates/tenant-template/design-system.md"
    "templates/tenant-template/ux.md"
    "templates/tenant-template/brand-voice.md"
    "templates/tenant-template/README.md"
    "templates/tenant-template/.github/workflows/validate-tenant.yml"
)
for f in "${TENANT_REQUIRED[@]}"; do
    if [ -f "$f" ]; then check_ok "$f"; else check_fail "$f fehlt"; fi
done

# CLAUDE.md muss die MANDANTEN-MODUS-Sektion haben
if grep -q "## MANDANTEN-MODUS" CLAUDE.md 2>/dev/null; then
    check_ok "CLAUDE.md hat MANDANTEN-MODUS-Sektion"
else
    check_fail "CLAUDE.md fehlt MANDANTEN-MODUS-Sektion"
fi

# update-Scripts muessen den tenant-Pull enthalten
for s in update.sh update.ps1; do
    if grep -q "tenant_repo" "$s" 2>/dev/null; then
        check_ok "$s zieht Mandanten-Overlay (tenant_repo)"
    else
        check_fail "$s fehlt Mandanten-Overlay-Stage (tenant_repo)"
    fi
done

# ---------------------------------------------------------------------------
section "Ergebnis"

if [ "$FAIL" -eq 0 ]; then
    printf "${GREEN}All checks passed.${NC}\n"
    exit 0
else
    printf "${RED}%d Check(s) fehlgeschlagen.${NC}\n" "$FAIL"
    exit 1
fi
