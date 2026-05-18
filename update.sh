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

# AI-PROVENANCE.md initialisieren falls noch nicht vorhanden (Append-only Log!)
if [ -f "$AGENCY_DIR/templates/AI-PROVENANCE.md" ] && [ ! -f "$TARGET_DIR/AI-PROVENANCE.md" ]; then
    cp "$AGENCY_DIR/templates/AI-PROVENANCE.md" "$TARGET_DIR/AI-PROVENANCE.md"
    echo "  AI-PROVENANCE.md -> Projekt-Root initialisiert (append-only Log)"
elif [ -f "$TARGET_DIR/AI-PROVENANCE.md" ]; then
    echo "  AI-PROVENANCE.md existiert bereits (nicht ueberschrieben — Append-only)"
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
