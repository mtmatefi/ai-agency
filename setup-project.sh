#!/usr/bin/env bash
# setup-project.sh
# One Stop Agency — Neues Projekt einrichten (Mac/Linux)
# Initialisiert ein Projekt mit CLAUDE.md und den Agency-Dateien.
#
# VERWENDUNG:
#   cd /pfad/zu/neuem/projekt
#   bash /pfad/zu/one-stop-agency/setup-project.sh
#
# MIT LOKALEM PFAD (gleicher Rechner, schneller):
#   bash /pfad/zu/one-stop-agency/setup-project.sh /pfad/zu/one-stop-agency

set -e

AGENCY_LOCAL_PATH="${1:-}"
REPO_URL="${AGENCY_REPO_URL:-https://raw.githubusercontent.com/mtmatefi/ai-agency/main}"
PROJECT_DIR="$(pwd)"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "One Stop Agency — Projekt Setup"
echo "================================"
echo "Projekt: $PROJECT_DIR"
echo ""

# Option A: Lokaler Pfad (gleicher Rechner, schneller)
if [ -n "$AGENCY_LOCAL_PATH" ] && [ -d "$AGENCY_LOCAL_PATH" ]; then
    echo "Modus: Lokale Kopie von $AGENCY_LOCAL_PATH"

    # CLAUDE.md direkt ins Projekt-Root
    cp "$AGENCY_LOCAL_PATH/CLAUDE.md" "$PROJECT_DIR/CLAUDE.md"
    echo "  OK  CLAUDE.md"

    # Teams-Ordner
    mkdir -p "$PROJECT_DIR/.agency/teams"
    cp "$AGENCY_LOCAL_PATH/teams/"*.md "$PROJECT_DIR/.agency/teams/"
    echo "  OK  teams/ (alle 14 Team-Dateien)"

    # Templates-Ordner (AI-Provenance + Snippets)
    if [ -d "$AGENCY_LOCAL_PATH/templates" ]; then
        mkdir -p "$PROJECT_DIR/.agency/templates"
        cp "$AGENCY_LOCAL_PATH/templates/"*.md "$PROJECT_DIR/.agency/templates/"
        echo "  OK  templates/"

        # AI-PROVENANCE.md ins Projekt-Root initialisieren (nur wenn nicht vorhanden!)
        if [ ! -f "$PROJECT_DIR/AI-PROVENANCE.md" ]; then
            cp "$AGENCY_LOCAL_PATH/templates/AI-PROVENANCE.md" "$PROJECT_DIR/AI-PROVENANCE.md"
            echo "  OK  AI-PROVENANCE.md (initialisiert in Projekt-Root)"
        else
            echo "  OK  AI-PROVENANCE.md existiert bereits (Append-only — nicht ueberschrieben)"
        fi
    fi

# Option B: Von GitHub laden
else
    echo "Modus: Download von GitHub ($REPO_URL)"
    echo ""

    UPDATE_SCRIPT="$SCRIPT_DIR/update.sh"
    if [ -f "$UPDATE_SCRIPT" ]; then
        bash "$UPDATE_SCRIPT" "$PROJECT_DIR"
    else
        echo "update.sh nicht gefunden. Bitte manuell ausfuehren."
    fi
fi

# .gitignore: .agency/ Ordner ausschliessen
GITIGNORE="$PROJECT_DIR/.gitignore"
if [ -f "$GITIGNORE" ]; then
    if ! grep -q "\.agency/" "$GITIGNORE"; then
        echo "" >> "$GITIGNORE"
        echo "# One Stop Agency (Claude Team)" >> "$GITIGNORE"
        echo ".agency/" >> "$GITIGNORE"
        echo "  OK  .gitignore aktualisiert (.agency/ hinzugefuegt)"
    fi
else
    echo "# One Stop Agency (Claude Team)" > "$GITIGNORE"
    echo ".agency/" >> "$GITIGNORE"
    echo "  OK  .gitignore erstellt"
fi

echo ""
echo "Setup abgeschlossen!"
echo ""
echo "Naechste Schritte:"
echo "  1. Oeffne das Projekt in Cursor oder Claude Code"
echo "  2. CLAUDE.md wird automatisch geladen"
echo "  3. Starte eine Aufgabe — das Team erkennt automatisch was gebraucht wird"
echo ""
echo "Aktualisierung: bash update.sh (laedt neueste Version von GitHub)"
echo ""
