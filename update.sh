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
)

echo ""
echo "One Stop Agency — Update"
echo "========================"
echo "Ziel: $TARGET_DIR"
echo ""

# Verzeichnisstruktur anlegen
mkdir -p "$AGENCY_DIR/teams"

SUCCESS=0
FAIL=0

for FILE in "${FILES[@]}"; do
    URL="$REPO_URL/$FILE"
    LOCAL_PATH="$AGENCY_DIR/$FILE"

    # Unterverzeichnis erstellen falls noetig
    mkdir -p "$(dirname "$LOCAL_PATH")"

    if curl -fsSL "$URL" -o "$LOCAL_PATH" 2>/dev/null; then
        echo "  OK  $FILE"
        ((SUCCESS++))
    else
        echo "  FAIL $FILE"
        ((FAIL++))
    fi
done

# CLAUDE.md ins Projekt-Root kopieren (wird von Claude Code automatisch geladen)
if [ -f "$AGENCY_DIR/CLAUDE.md" ]; then
    cp "$AGENCY_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
    echo ""
    echo "  CLAUDE.md -> Projekt-Root kopiert"
fi

echo ""
if [ $FAIL -eq 0 ]; then
    echo "Update abgeschlossen: $SUCCESS erfolgreich, $FAIL Fehler"
else
    echo "Update abgeschlossen: $SUCCESS erfolgreich, $FAIL Fehler"
    echo ""
    echo "Hinweis: Pruefe ob der Repo-URL korrekt ist:"
    echo "  Aktuell: $REPO_URL"
    echo "  Aendern: AGENCY_REPO_URL='https://raw.githubusercontent.com/DEIN-USERNAME/DEIN-REPO/main' bash update.sh"
fi
echo ""
