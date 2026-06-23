#!/usr/bin/env bash
# update.sh
# One Stop Agency — Update Script (Mac/Linux)
# Laedt die neueste Version von GitHub und aktualisiert das aktuelle Projekt.
#
# VERWENDUNG:
#   cd /pfad/zu/deinem/projekt
#   bash /pfad/zu/one-stop-agency/update.sh
#
# ODER als Alias (einmalig in ~/.zshrc oder ~/.bashrc):
#   alias update-agency='bash /pfad/zu/one-stop-agency/update.sh'

set -e

REPO_URL="${AGENCY_REPO_URL:-https://raw.githubusercontent.com/mtmatefi/ai-agency/main}"
TARGET_DIR="${1:-$(pwd)}"
AGENCY_DIR="$TARGET_DIR/.agency"

FILES=(
    "CLAUDE.md"
    "GOVERNANCE.md"
    "teams/development-qa.md"
    "teams/infrastructure.md"
    "teams/security.md"
    "teams/compliance.md"
    "teams/legal.md"
    "teams/ux-ui.md"
    "teams/graphic-design.md"
    "teams/marketing-seo.md"
    "teams/content-editorial.md"
    "teams/product-management.md"
    "teams/sales.md"
    "teams/data-analytics.md"
    "teams/finance.md"
    "teams/customer-success.md"
    "templates/AI-PROVENANCE.md"
    "templates/ai-headers-snippets.md"
)

echo ""
echo "One Stop Agency — Update"
echo "========================"
echo "Ziel: $TARGET_DIR"

# Profil aus .agency/config.json lesen (falls vorhanden)
ACTIVE_TEAMS=""
PROFILE_NAME=""
CONFIG="$TARGET_DIR/.agency/config.json"
if [ -f "$CONFIG" ]; then
    if command -v jq >/dev/null 2>&1; then
        PROFILE_NAME=$(jq -r '.profile // empty' "$CONFIG" 2>/dev/null)
        ACTIVE_TEAMS=$(jq -r '.source.teams[]? // empty' "$CONFIG" 2>/dev/null | tr '\n' '|' | sed 's/|$//')
        if [ -n "$ACTIVE_TEAMS" ]; then
            COUNT=$(printf '%s' "$ACTIVE_TEAMS" | tr '|' '\n' | wc -l | tr -d ' ')
            echo "Profil: $PROFILE_NAME (Teams aktiv: $COUNT/14)"
        fi
    else
        echo "WARN: jq nicht installiert — Profil-Filter ignoriert, alle Teams werden synced."
        echo "      (Tipp: brew/apt install jq fuer Profile-Support)"
    fi
fi
echo ""

# Verzeichnisstruktur anlegen
mkdir -p "$AGENCY_DIR/teams"

SUCCESS=0
FAIL=0
SKIP=0

for FILE in "${FILES[@]}"; do
    # Profile-Filter: nur Team-Files filtern, CLAUDE.md + Templates immer syncen
    if [ -n "$ACTIVE_TEAMS" ] && [[ "$FILE" == teams/* ]]; then
        TEAM_NAME=$(basename "$FILE" .md)
        if [[ "|$ACTIVE_TEAMS|" != *"|$TEAM_NAME|"* ]]; then
            echo "  SKIP $FILE (nicht in Profil '$PROFILE_NAME')"
            # Eventuell vorhandene alte Datei entfernen
            if [ -f "$AGENCY_DIR/$FILE" ]; then rm -f "$AGENCY_DIR/$FILE"; fi
            SKIP=$((SKIP + 1))
            continue
        fi
    fi

    URL="$REPO_URL/$FILE"
    LOCAL_PATH="$AGENCY_DIR/$FILE"

    # Unterverzeichnis erstellen falls noetig
    mkdir -p "$(dirname "$LOCAL_PATH")"

    if curl -fsSL "$URL" -o "$LOCAL_PATH" 2>/dev/null; then
        echo "  OK  $FILE"
        SUCCESS=$((SUCCESS + 1))
    else
        echo "  FAIL $FILE"
        FAIL=$((FAIL + 1))
    fi
done

# CLAUDE.md ins Projekt-Root kopieren (wird von Claude Code automatisch geladen)
if [ -f "$AGENCY_DIR/CLAUDE.md" ]; then
    cp "$AGENCY_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
    echo ""
    echo "  CLAUDE.md -> Projekt-Root kopiert"
fi

# GOVERNANCE.md ins Projekt-Root kopieren (Verfassung, hoechste Praezedenz)
if [ -f "$AGENCY_DIR/GOVERNANCE.md" ]; then
    cp "$AGENCY_DIR/GOVERNANCE.md" "$TARGET_DIR/GOVERNANCE.md"
    echo "  GOVERNANCE.md -> Projekt-Root kopiert"
fi

# AI-PROVENANCE.md initialisieren falls noch nicht vorhanden (Append-only Log!)
if [ -f "$AGENCY_DIR/templates/AI-PROVENANCE.md" ] && [ ! -f "$TARGET_DIR/AI-PROVENANCE.md" ]; then
    cp "$AGENCY_DIR/templates/AI-PROVENANCE.md" "$TARGET_DIR/AI-PROVENANCE.md"
    echo "  AI-PROVENANCE.md -> Projekt-Root initialisiert (append-only Log)"
elif [ -f "$TARGET_DIR/AI-PROVENANCE.md" ]; then
    echo "  AI-PROVENANCE.md existiert bereits (nicht ueberschrieben — Append-only)"
fi

# ---------------------------------------------------------------------------
# Stufe 2: Mandanten-Overlay ziehen (falls 'tenant' in config.json)
# ---------------------------------------------------------------------------
if [ -f "$CONFIG" ] && command -v jq >/dev/null 2>&1; then
    TENANT=$(jq -r '.tenant // empty' "$CONFIG" 2>/dev/null)
    TENANT_REPO=$(jq -r '.tenant_repo // empty' "$CONFIG" 2>/dev/null)
    TENANT_PIN=$(jq -r '.tenant_pin // empty' "$CONFIG" 2>/dev/null)
    if [ -n "$TENANT" ] && [ -n "$TENANT_REPO" ]; then
        # Token fuer PRIVATE Mandanten-Repos aufloesen (optional, Reihenfolge: env -> gh)
        TENANT_TOKEN="${AGENCY_TENANT_TOKEN:-${GITHUB_TOKEN:-}}"
        if [ -z "$TENANT_TOKEN" ] && command -v gh >/dev/null 2>&1; then
            TENANT_TOKEN="$(gh auth token 2>/dev/null || true)"
        fi
        # owner/repo/ref aus raw-URL parsen (fuer Contents-API bei privaten Repos)
        T_OWNER=""; T_REPO=""; T_REF=""
        case "$TENANT_REPO" in
            https://raw.githubusercontent.com/*)
                REST="${TENANT_REPO#https://raw.githubusercontent.com/}"
                T_OWNER="$(printf '%s' "$REST" | cut -d/ -f1)"
                T_REPO="$(printf '%s' "$REST" | cut -d/ -f2)"
                T_REF="$(printf '%s' "$REST" | cut -d/ -f3)"
                ;;
        esac
        # Pin aufloesen: tenant_pin ueberschreibt den Ref
        if [ -n "$TENANT_PIN" ]; then
            T_REF="$TENANT_PIN"
            TENANT_BASE="${TENANT_REPO%/*}/$TENANT_PIN"
        else
            TENANT_BASE="$TENANT_REPO"
        fi

        if [ -n "$TENANT_TOKEN" ] && [ -n "$T_OWNER" ] && [ -n "$T_REPO" ]; then
            USE_API=1
            echo ""
            echo "Mandant: $TENANT  (privat, Contents-API $T_OWNER/$T_REPO@$T_REF)"
        else
            USE_API=0
            echo ""
            echo "Mandant: $TENANT  (Overlay aus $TENANT_BASE)"
            [ -z "$TENANT_TOKEN" ] && echo "  Hinweis: kein Token (AGENCY_TENANT_TOKEN / GITHUB_TOKEN / gh) — funktioniert nur bei OEFFENTLICHEM Tenant-Repo."
        fi

        TENANT_DIR="$AGENCY_DIR/tenant"
        mkdir -p "$TENANT_DIR"
        TENANT_FILES=("config.json" "standards.md" "design-system.md" "ux.md" "brand-voice.md")
        for TF in "${TENANT_FILES[@]}"; do
            OK=1
            if [ "$USE_API" -eq 1 ]; then
                curl -fsSL \
                    -H "Authorization: Bearer $TENANT_TOKEN" \
                    -H "Accept: application/vnd.github.raw" \
                    "https://api.github.com/repos/$T_OWNER/$T_REPO/contents/$TF?ref=$T_REF" \
                    -o "$TENANT_DIR/$TF" 2>/dev/null || OK=0
            else
                curl -fsSL "$TENANT_BASE/$TF" -o "$TENANT_DIR/$TF" 2>/dev/null || OK=0
            fi
            if [ "$OK" -eq 1 ]; then
                echo "  OK  tenant/$TF"
                SUCCESS=$((SUCCESS + 1))
            else
                echo "  FAIL tenant/$TF"
                FAIL=$((FAIL + 1))
            fi
        done
    fi
elif [ -f "$CONFIG" ] && ! command -v jq >/dev/null 2>&1; then
    if grep -q '"tenant"' "$CONFIG" 2>/dev/null; then
        echo ""
        echo "WARN: 'tenant' in config.json, aber jq fehlt — Mandanten-Overlay NICHT gezogen."
        echo "      (jq installieren fuer Mandanten-Support)"
    fi
fi

echo ""
echo "Update abgeschlossen: $SUCCESS erfolgreich, $SKIP skipped (Profil), $FAIL Fehler"
if [ $FAIL -gt 0 ]; then
    echo ""
    echo "Hinweis: Pruefe ob der Repo-URL korrekt ist:"
    echo "  Aktuell: $REPO_URL"
    echo "  Aendern: AGENCY_REPO_URL='https://raw.githubusercontent.com/mtmatefi/ai-agency/main' bash update.sh"
fi
echo ""
