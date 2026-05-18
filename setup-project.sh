#!/usr/bin/env bash
# setup-project.sh
# One Stop Agency — Neues Projekt einrichten (Mac/Linux)
# Initialisiert ein Projekt mit CLAUDE.md, Agency-Dateien und einem Profil.
#
# VERWENDUNG:
#   cd /pfad/zu/neuem/projekt
#   bash /pfad/zu/one-stop-agency/setup-project.sh [--profile NAME] [/pfad/zu/agency]
#
# Beispiele:
#   bash setup-project.sh                              # interaktive Profil-Auswahl
#   bash setup-project.sh --profile internal-tool     # ohne Frage
#   bash setup-project.sh --profile mobile-app-only /pfad/agency  # lokal + Profil

set -e

PROFILE=""
AGENCY_LOCAL_PATH=""

# Argumente parsen
while [ $# -gt 0 ]; do
    case "$1" in
        --profile)
            PROFILE="$2"; shift 2 ;;
        --profile=*)
            PROFILE="${1#*=}"; shift ;;
        -h|--help)
            echo "Verwendung: $0 [--profile NAME] [agency-path]"
            echo "Profile: saas-eu-b2b | internal-tool | mobile-app-only | agency-client-work | oss-library"
            exit 0 ;;
        *)
            AGENCY_LOCAL_PATH="$1"; shift ;;
    esac
done

REPO_URL="${AGENCY_REPO_URL:-https://raw.githubusercontent.com/mtmatefi/ai-agency/main}"
PROJECT_DIR="$(pwd)"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
KNOWN_PROFILES=("saas-eu-b2b" "internal-tool" "mobile-app-only" "agency-client-work" "oss-library")

# Interaktive Profil-Auswahl wenn nicht via Flag und nicht via Config schon gesetzt
if [ -z "$PROFILE" ] && [ ! -f "$PROJECT_DIR/.agency/config.json" ]; then
    if [ -t 0 ]; then
        echo ""
        echo "Bitte Projekt-Profil waehlen:"
        i=1
        for p in "${KNOWN_PROFILES[@]}"; do
            echo "  $i) $p"
            i=$((i+1))
        done
        echo "  (Enter = saas-eu-b2b, Default)"
        printf "Profil: "
        read -r SELECTION
        if [ -z "$SELECTION" ]; then
            PROFILE="saas-eu-b2b"
        elif printf '%s' "$SELECTION" | grep -qE '^[0-9]+$'; then
            IDX=$((SELECTION - 1))
            if [ "$IDX" -ge 0 ] && [ "$IDX" -lt "${#KNOWN_PROFILES[@]}" ]; then
                PROFILE="${KNOWN_PROFILES[$IDX]}"
            else
                echo "Ungueltige Auswahl, nehme saas-eu-b2b."
                PROFILE="saas-eu-b2b"
            fi
        else
            PROFILE="$SELECTION"
        fi
    else
        PROFILE="saas-eu-b2b"  # non-TTY
    fi
fi

echo ""
echo "One Stop Agency — Projekt Setup"
echo "================================"
echo "Projekt: $PROJECT_DIR"
echo "Profil:  ${PROFILE:-(uebernommen aus bestehender .agency/config.json)}"
echo ""

# Profil-Datei laden + .agency/config.json schreiben
if [ -n "$PROFILE" ]; then
    mkdir -p "$PROJECT_DIR/.agency"
    PROFILE_JSON=""
    if [ -n "$AGENCY_LOCAL_PATH" ] && [ -f "$AGENCY_LOCAL_PATH/profiles/$PROFILE.json" ]; then
        PROFILE_JSON=$(cat "$AGENCY_LOCAL_PATH/profiles/$PROFILE.json")
    elif [ -f "$SCRIPT_DIR/profiles/$PROFILE.json" ]; then
        PROFILE_JSON=$(cat "$SCRIPT_DIR/profiles/$PROFILE.json")
    else
        PROFILE_JSON=$(curl -fsSL "$REPO_URL/profiles/$PROFILE.json" 2>/dev/null || echo "")
    fi

    if [ -z "$PROFILE_JSON" ]; then
        echo "ERROR: Profil '$PROFILE' nicht gefunden (weder lokal noch unter $REPO_URL/profiles/)."
        echo "Bekannte Profile: ${KNOWN_PROFILES[*]}"
        exit 1
    fi

    # config.json mit Metadaten anreichern
    TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    printf '{\n  "profile": "%s",\n  "installed_at": "%s",\n  "source": %s\n}\n' \
        "$PROFILE" "$TIMESTAMP" "$PROFILE_JSON" > "$PROJECT_DIR/.agency/config.json"
    echo "  OK  .agency/config.json (Profil: $PROFILE)"
fi

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
