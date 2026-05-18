# update.ps1
# One Stop Agency — Update Script (Windows/PowerShell)
# Laedt die neueste Version von GitHub und aktualisiert das aktuelle Projekt.
#
# VERWENDUNG:
#   cd C:\Pfad\zu\deinem\Projekt
#   .\path\to\one-stop-agency\update.ps1
#
# ODER als globalen Alias (einmalig in PowerShell-Profil):
#   function Update-Agency { & "C:\Pfad\zu\one-stop-agency\update.ps1" }

param(
    [string]$RepoUrl = "https://raw.githubusercontent.com/mtmatefi/ai-agency/main",
    [string]$TargetDir = $PWD
)

$AgencyDir = "$TargetDir\.agency"
$FilesToSync = @(
    "CLAUDE.md",
    "teams/development-qa.md",
    "teams/infrastructure.md",
    "teams/security.md",
    "teams/compliance.md",
    "teams/legal.md",
    "teams/ux-ui.md",
    "teams/graphic-design.md",
    "teams/marketing-seo.md",
    "teams/content-editorial.md",
    "teams/product-management.md",
    "teams/sales.md",
    "teams/data-analytics.md",
    "teams/finance.md",
    "teams/customer-success.md"
)

Write-Host ""
Write-Host "One Stop Agency — Update" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan
Write-Host "Ziel: $TargetDir" -ForegroundColor Gray
Write-Host ""

# Verzeichnisstruktur anlegen
New-Item -ItemType Directory -Path "$AgencyDir\teams" -Force | Out-Null

$SuccessCount = 0
$FailCount = 0

foreach ($File in $FilesToSync) {
    $Url = "$RepoUrl/$File"
    $LocalPath = "$AgencyDir\$File"

    # Unterverzeichnis erstellen falls noetig
    $Dir = Split-Path $LocalPath -Parent
    New-Item -ItemType Directory -Path $Dir -Force | Out-Null

    try {
        $Response = Invoke-WebRequest -Uri $Url -UseBasicParsing -ErrorAction Stop
        Set-Content -Path $LocalPath -Value $Response.Content -Encoding UTF8
        Write-Host "  OK  $File" -ForegroundColor Green
        $SuccessCount++
    }
    catch {
        Write-Host "  FAIL $File — $($_.Exception.Message)" -ForegroundColor Red
        $FailCount++
    }
}

# CLAUDE.md ins Projekt-Root kopieren (wird von Claude Code automatisch geladen)
$ClaudeSource = "$AgencyDir\CLAUDE.md"
$ClaudeTarget = "$TargetDir\CLAUDE.md"

if (Test-Path $ClaudeSource) {
    Copy-Item -Path $ClaudeSource -Destination $ClaudeTarget -Force
    Write-Host ""
    Write-Host "  CLAUDE.md -> Projekt-Root kopiert" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Update abgeschlossen: $SuccessCount erfolgreich, $FailCount Fehler" -ForegroundColor $(if ($FailCount -eq 0) { "Green" } else { "Yellow" })

if ($FailCount -gt 0) {
    Write-Host ""
    Write-Host "Hinweis: Pruefe ob der Repo-URL korrekt ist:" -ForegroundColor Yellow
    Write-Host "  Aktuell: $RepoUrl" -ForegroundColor Gray
    Write-Host "  Aendern: .\update.ps1 -RepoUrl 'https://raw.githubusercontent.com/mtmatefi/ai-agency/main'" -ForegroundColor Gray
}

Write-Host ""
