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
    [string]$RepoUrl = "https://raw.githubusercontent.com/mtmatefi/ai-agency/main",
    [string]$Profile = ""
)

$ProjectDir = $PWD
$KnownProfiles = @("saas-eu-b2b","internal-tool","mobile-app-only","agency-client-work","oss-library")

# Interaktive Profil-Auswahl wenn nicht via Parameter und nicht schon konfiguriert
if (-not $Profile -and -not (Test-Path "$ProjectDir\.agency\config.json")) {
    if ([Environment]::UserInteractive -and -not [Console]::IsInputRedirected) {
        Write-Host ""
        Write-Host "Bitte Projekt-Profil waehlen:" -ForegroundColor Cyan
        for ($i=0; $i -lt $KnownProfiles.Count; $i++) {
            Write-Host ("  {0}) {1}" -f ($i+1), $KnownProfiles[$i]) -ForegroundColor White
        }
        Write-Host "  (Enter = saas-eu-b2b, Default)" -ForegroundColor Gray
        $Selection = Read-Host "Profil"
        if (-not $Selection) {
            $Profile = "saas-eu-b2b"
        } elseif ($Selection -match '^\d+$') {
            $Idx = [int]$Selection - 1
            if ($Idx -ge 0 -and $Idx -lt $KnownProfiles.Count) {
                $Profile = $KnownProfiles[$Idx]
            } else {
                Write-Host "Ungueltige Auswahl, nehme saas-eu-b2b." -ForegroundColor Yellow
                $Profile = "saas-eu-b2b"
            }
        } else {
            $Profile = $Selection
        }
    } else {
        $Profile = "saas-eu-b2b"  # non-interactive
    }
}

Write-Host ""
Write-Host "One Stop Agency — Projekt Setup" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host "Projekt: $ProjectDir" -ForegroundColor Gray
if ($Profile) {
    Write-Host "Profil:  $Profile" -ForegroundColor Gray
} else {
    Write-Host "Profil:  (uebernommen aus bestehender .agency/config.json)" -ForegroundColor Gray
}
Write-Host ""

# Profil-Datei laden + .agency/config.json schreiben
if ($Profile) {
    New-Item -ItemType Directory -Path "$ProjectDir\.agency" -Force | Out-Null
    $ProfileJson = ""
    $LocalProfile = ""

    if ($AgencyPath -and (Test-Path "$AgencyPath\profiles\$Profile.json")) {
        $LocalProfile = "$AgencyPath\profiles\$Profile.json"
    } elseif (Test-Path (Join-Path (Split-Path $MyInvocation.MyCommand.Path) "profiles\$Profile.json")) {
        $LocalProfile = Join-Path (Split-Path $MyInvocation.MyCommand.Path) "profiles\$Profile.json"
    }

    if ($LocalProfile) {
        $ProfileJson = Get-Content $LocalProfile -Raw
    } else {
        try {
            $ProfileJson = (Invoke-WebRequest -Uri "$RepoUrl/profiles/$Profile.json" -UseBasicParsing -ErrorAction Stop).Content
        } catch {
            Write-Host "ERROR: Profil '$Profile' nicht gefunden (weder lokal noch unter $RepoUrl/profiles/)." -ForegroundColor Red
            Write-Host "Bekannte Profile: $($KnownProfiles -join ', ')" -ForegroundColor Yellow
            exit 1
        }
    }

    $Timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    $ConfigContent = @"
{
  "profile": "$Profile",
  "installed_at": "$Timestamp",
  "source": $ProfileJson
}
"@
    Set-Content -Path "$ProjectDir\.agency\config.json" -Value $ConfigContent -Encoding UTF8
    Write-Host "  OK  .agency/config.json (Profil: $Profile)" -ForegroundColor Green
}

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

    # Templates-Ordner (AI-Provenance + Snippets)
    if (Test-Path "$AgencyPath\templates") {
        New-Item -ItemType Directory -Path "$ProjectDir\.agency\templates" -Force | Out-Null
        Copy-Item "$AgencyPath\templates\*.md" "$ProjectDir\.agency\templates\" -Force
        Write-Host "  OK  templates/" -ForegroundColor Green

        # AI-PROVENANCE.md ins Projekt-Root initialisieren (nur wenn nicht vorhanden — Append-only!)
        if (-not (Test-Path "$ProjectDir\AI-PROVENANCE.md")) {
            Copy-Item "$AgencyPath\templates\AI-PROVENANCE.md" "$ProjectDir\AI-PROVENANCE.md" -Force
            Write-Host "  OK  AI-PROVENANCE.md (initialisiert in Projekt-Root)" -ForegroundColor Green
        } else {
            Write-Host "  OK  AI-PROVENANCE.md existiert bereits (Append-only — nicht ueberschrieben)" -ForegroundColor Gray
        }
    }
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
