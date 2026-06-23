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
    "teams/customer-success.md",
    "templates/AI-PROVENANCE.md",
    "templates/ai-headers-snippets.md"
)

Write-Host ""
Write-Host "One Stop Agency — Update" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan
Write-Host "Ziel: $TargetDir" -ForegroundColor Gray

# Profil aus .agency/config.json lesen (falls vorhanden)
$ActiveTeams = $null
$ProfileName = ""
$ConfigPath = "$TargetDir\.agency\config.json"
if (Test-Path $ConfigPath) {
    try {
        $Config = Get-Content $ConfigPath -Raw | ConvertFrom-Json
        $ProfileName = $Config.profile
        if ($Config.source -and $Config.source.teams) {
            $ActiveTeams = @($Config.source.teams)
            Write-Host "Profil: $ProfileName (Teams aktiv: $($ActiveTeams.Count)/14)" -ForegroundColor Gray
        }
    } catch {
        Write-Host "WARN: .agency/config.json konnte nicht gelesen werden — alle Teams werden synced." -ForegroundColor Yellow
    }
}
Write-Host ""

# Verzeichnisstruktur anlegen
New-Item -ItemType Directory -Path "$AgencyDir\teams" -Force | Out-Null

$SuccessCount = 0
$FailCount = 0

$SkipCount = 0
foreach ($File in $FilesToSync) {
    # Profile-Filter: nur Team-Files filtern, CLAUDE.md + Templates immer syncen
    if ($ActiveTeams -and $File -like "teams/*") {
        $TeamName = ($File -replace "^teams/", "") -replace "\.md$", ""
        if ($TeamName -notin $ActiveTeams) {
            Write-Host "  SKIP $File (nicht in Profil '$ProfileName')" -ForegroundColor DarkGray
            # Eventuell vorhandene alte Datei entfernen
            $StaleLocal = "$AgencyDir\$File"
            if (Test-Path $StaleLocal) { Remove-Item $StaleLocal -Force }
            $SkipCount++
            continue
        }
    }

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

# AI-PROVENANCE.md initialisieren falls noch nicht vorhanden (Append-only Log — NICHT ueberschreiben!)
$ProvenanceSource = "$AgencyDir\templates\AI-PROVENANCE.md"
$ProvenanceTarget = "$TargetDir\AI-PROVENANCE.md"

if ((Test-Path $ProvenanceSource) -and -not (Test-Path $ProvenanceTarget)) {
    Copy-Item -Path $ProvenanceSource -Destination $ProvenanceTarget -Force
    Write-Host "  AI-PROVENANCE.md -> Projekt-Root initialisiert (append-only Log)" -ForegroundColor Cyan
}
elseif (Test-Path $ProvenanceTarget) {
    Write-Host "  AI-PROVENANCE.md existiert bereits (nicht ueberschrieben — Append-only)" -ForegroundColor Gray
}

# ---------------------------------------------------------------------------
# Stufe 2: Mandanten-Overlay ziehen (falls 'tenant' in config.json)
# ---------------------------------------------------------------------------
if ($Config -and $Config.tenant -and $Config.tenant_repo) {
    $Tenant = $Config.tenant
    $TenantRepo = $Config.tenant_repo
    $TenantPin = $Config.tenant_pin
    # Token fuer PRIVATE Mandanten-Repos aufloesen (optional, Reihenfolge: env -> gh)
    $TenantToken = $env:AGENCY_TENANT_TOKEN
    if (-not $TenantToken) { $TenantToken = $env:GITHUB_TOKEN }
    if (-not $TenantToken -and (Get-Command gh -ErrorAction SilentlyContinue)) {
        try { $TenantToken = (gh auth token 2>$null) } catch {}
    }
    # owner/repo/ref aus raw-URL parsen (fuer Contents-API bei privaten Repos)
    $TOwner = $null; $TRepo = $null; $TRef = $null
    if ($TenantRepo -match '^https://raw\.githubusercontent\.com/([^/]+)/([^/]+)/([^/]+)') {
        $TOwner = $Matches[1]; $TRepo = $Matches[2]; $TRef = $Matches[3]
    }
    if ($TenantPin) {
        $TRef = $TenantPin
        $TenantBase = ($TenantRepo -replace '/[^/]+$', "/$TenantPin")
    } else {
        $TenantBase = $TenantRepo
    }

    $UseApi = ([bool]$TenantToken -and [bool]$TOwner -and [bool]$TRepo)
    Write-Host ""
    if ($UseApi) {
        Write-Host "Mandant: $Tenant (privat, Contents-API $TOwner/$TRepo@$TRef)" -ForegroundColor Cyan
    } else {
        Write-Host "Mandant: $Tenant (Overlay aus $TenantBase)" -ForegroundColor Cyan
        if (-not $TenantToken) { Write-Host "  Hinweis: kein Token (AGENCY_TENANT_TOKEN / GITHUB_TOKEN / gh) — funktioniert nur bei OEFFENTLICHEM Tenant-Repo." -ForegroundColor Yellow }
    }

    $TenantDir = "$AgencyDir\tenant"
    New-Item -ItemType Directory -Path $TenantDir -Force | Out-Null
    $TenantFiles = @("config.json", "standards.md", "design-system.md", "ux.md", "brand-voice.md")
    foreach ($TF in $TenantFiles) {
        try {
            if ($UseApi) {
                $Headers = @{ Authorization = "Bearer $TenantToken"; Accept = "application/vnd.github.raw" }
                $R = Invoke-WebRequest -Uri "https://api.github.com/repos/$TOwner/$TRepo/contents/$($TF)?ref=$TRef" -Headers $Headers -UseBasicParsing -ErrorAction Stop
            } else {
                $R = Invoke-WebRequest -Uri "$TenantBase/$TF" -UseBasicParsing -ErrorAction Stop
            }
            Set-Content -Path "$TenantDir\$TF" -Value $R.Content -Encoding UTF8
            Write-Host "  OK  tenant/$TF" -ForegroundColor Green
            $SuccessCount++
        }
        catch {
            Write-Host "  FAIL tenant/$TF — $($_.Exception.Message)" -ForegroundColor Red
            $FailCount++
        }
    }
}

Write-Host ""
Write-Host ("Update abgeschlossen: {0} erfolgreich, {1} skipped (Profil), {2} Fehler" -f $SuccessCount, $SkipCount, $FailCount) -ForegroundColor $(if ($FailCount -eq 0) { "Green" } else { "Yellow" })

if ($FailCount -gt 0) {
    Write-Host ""
    Write-Host "Hinweis: Pruefe ob der Repo-URL korrekt ist:" -ForegroundColor Yellow
    Write-Host "  Aktuell: $RepoUrl" -ForegroundColor Gray
    Write-Host "  Aendern: .\update.ps1 -RepoUrl 'https://raw.githubusercontent.com/mtmatefi/ai-agency/main'" -ForegroundColor Gray
}

Write-Host ""
