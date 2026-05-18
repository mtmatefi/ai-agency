# setup-project.ps1
# One Stop Agency — Neues Projekt einrichten (Windows/PowerShell)
# Initialisiert ein Projekt mit CLAUDE.md und den Agency-Dateien.
#
# VERWENDUNG:
#   cd C:\Pfad\zu\neuem\Projekt
#   & "C:\Pfad\zu\one-stop-agency\setup-project.ps1"
#
# PARAMETER:
#   -AgencyPath  Pfad zur lokalen One-Stop-Agency Kopie (optional)
#                Falls nicht angegeben, wird von GitHub geladen.

param(
    [string]$AgencyPath = "",
    [string]$RepoUrl = "https://raw.githubusercontent.com/mtmatefi/ai-agency/main"
)

$ProjectDir = $PWD

Write-Host ""
Write-Host "One Stop Agency — Projekt Setup" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Projekt: $ProjectDir" -ForegroundColor Gray
Write-Host ""

# Option A: Lokaler Pfad (gleicher PC, schneller)
if ($AgencyPath -ne "" -and (Test-Path $AgencyPath)) {
    Write-Host "Modus: Lokale Kopie von $AgencyPath" -ForegroundColor Gray

    # CLAUDE.md direkt ins Projekt-Root
    Copy-Item "$AgencyPath\CLAUDE.md" "$ProjectDir\CLAUDE.md" -Force
    Write-Host "  OK  CLAUDE.md" -ForegroundColor Green

    # Teams-Ordner
    New-Item -ItemType Directory -Path "$ProjectDir\.agency\teams" -Force | Out-Null
    Copy-Item "$AgencyPath\teams\*.md" "$ProjectDir\.agency\teams\" -Force
    Write-Host "  OK  teams/ (alle 14 Team-Dateien)" -ForegroundColor Green
}
# Option B: Von GitHub laden
else {
    Write-Host "Modus: Download von GitHub ($RepoUrl)" -ForegroundColor Gray
    Write-Host ""

    # Update-Script aufrufen
    $UpdateScript = Join-Path (Split-Path $MyInvocation.MyCommand.Path) "update.ps1"
    if (Test-Path $UpdateScript) {
        & $UpdateScript -RepoUrl $RepoUrl -TargetDir $ProjectDir
    }
    else {
        Write-Host "update.ps1 nicht gefunden. Bitte manuell ausfuehren." -ForegroundColor Yellow
    }
}

# .gitignore: .agency/ Ordner ausschliessen (optional)
$GitIgnorePath = "$ProjectDir\.gitignore"
if (Test-Path $GitIgnorePath) {
    $Content = Get-Content $GitIgnorePath -Raw
    if ($Content -notmatch "\.agency/") {
        Add-Content -Path $GitIgnorePath -Value "`n# One Stop Agency (Claude Team)`n.agency/"
        Write-Host "  OK  .gitignore aktualisiert (.agency/ hinzugefuegt)" -ForegroundColor Green
    }
}
else {
    Set-Content -Path $GitIgnorePath -Value "# One Stop Agency (Claude Team)`n.agency/" -Encoding UTF8
    Write-Host "  OK  .gitignore erstellt" -ForegroundColor Green
}

Write-Host ""
Write-Host "Setup abgeschlossen!" -ForegroundColor Green
Write-Host ""
Write-Host "Naechste Schritte:" -ForegroundColor Cyan
Write-Host "  1. Oeffne das Projekt in Cursor oder Claude Code" -ForegroundColor White
Write-Host "  2. CLAUDE.md wird automatisch geladen" -ForegroundColor White
Write-Host "  3. Starte eine Aufgabe — das Team erkennt automatisch was gebraucht wird" -ForegroundColor White
Write-Host ""
Write-Host "Aktualisierung: .\update.ps1 (laedt neueste Version von GitHub)" -ForegroundColor Gray
Write-Host ""
