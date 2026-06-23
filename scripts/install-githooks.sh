#!/usr/bin/env bash
# scripts/install-githooks.sh
# Aktiviert die repo-eigenen Git-Hooks (.githooks/) via core.hooksPath.
# Idempotent — mehrfaches Ausfuehren ist unproblematisch.
#
# Verwendung:  bash scripts/install-githooks.sh
#
# @ai-assisted: claude-opus-4-8 via One-Stop-Agency / Kai Bauer (DevOps)
# @ai-date: 2026-06-23
# @ai-task: One-Shot-Installer fuer lokale Git-Hooks
# @human-review: OFFEN bis mtmatefi Sign-Off

set -eu

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [ ! -d .githooks ]; then
    echo "FEHLER: .githooks/ nicht gefunden. Bist du im Agency-Repo-Root?"
    exit 1
fi

git config core.hooksPath .githooks

# Ausfuehrbar machen (no-op auf Windows/Git-Bash, schadet aber nicht)
chmod +x .githooks/* 2>/dev/null || true

echo "OK — core.hooksPath = .githooks"
echo "Aktive Hooks:"
ls -1 .githooks | sed 's/^/  - /'
echo ""
echo "Ab jetzt laeuft 'scripts/validate.sh' + AI-PROVENANCE-Schutz vor jedem Commit."
echo "Notfall-Bypass eines einzelnen Commits: git commit --no-verify"
