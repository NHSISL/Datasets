<#
.SYNOPSIS
    Sets up the OLIDS testing environment.
.DESCRIPTION
    Installs uv (if needed), creates a .env file with Snowflake credentials,
    and installs Python dependencies.
#>

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "OLIDS Testing - Setup" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host ""

# --- Step 1: Execution policy (process-scoped, no admin needed) ---
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

# --- Step 2: Check for uv ---
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "uv not found on PATH. Installing..." -ForegroundColor Yellow
    Invoke-RestMethod https://astral.sh/uv/install.ps1 | Invoke-Expression

    # Refresh PATH from registry so we pick up the new binary
    $machinePath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$userPath;$machinePath"

    if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
        Write-Host "ERROR: uv installation succeeded but is still not on PATH." -ForegroundColor Red
        Write-Host "Close and reopen your terminal, then run this script again." -ForegroundColor Red
        exit 1
    }
    Write-Host "uv installed successfully." -ForegroundColor Green
} else {
    Write-Host "uv found: $(uv --version)" -ForegroundColor Green
}

# --- Step 3: Snowflake credentials ---
$envFile = Join-Path $PSScriptRoot ".env"
$needsSetup = $true

if (Test-Path $envFile) {
    # Parse existing values
    $existing = @{}
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^([^=]+)=(.*)$') {
            $existing[$Matches[1]] = $Matches[2]
        }
    }

    Write-Host ""
    Write-Host "Existing Snowflake configuration found:" -ForegroundColor Cyan
    foreach ($key in @('SNOWFLAKE_ACCOUNT', 'SNOWFLAKE_USER', 'SNOWFLAKE_WAREHOUSE', 'SNOWFLAKE_ROLE', 'SNOWFLAKE_DATABASE')) {
        $val = $existing[$key]
        if ($val) {
            Write-Host "  $key = $val" -ForegroundColor White
        }
    }
    Write-Host ""
    $change = Read-Host "Keep these settings? (Y/n)"
    if ($change -eq "n") {
        Remove-Item $envFile
    } else {
        Write-Host "Keeping existing credentials." -ForegroundColor Green
        $needsSetup = $false
    }
}

if ($needsSetup -and -not (Test-Path $envFile)) {
    Write-Host ""
    Write-Host "Snowflake Connection Setup" -ForegroundColor Cyan
    Write-Host "--------------------------" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Account identifier" -ForegroundColor White
    Write-Host "  Tip: right-click to paste" -ForegroundColor Yellow
    Write-Host "  In Snowflake (https://app.snowflake.com/), click your profile (bottom-left)" -ForegroundColor DarkGray
    Write-Host "  and copy the 'Account identifier' value from Account Details." -ForegroundColor DarkGray
    Write-Host "  Format: XXXXXXX-XXX  (e.g. ATKJNCU-NCL)" -ForegroundColor DarkGray
    $account = Read-Host "  SNOWFLAKE_ACCOUNT"

    Write-Host ""
    Write-Host "Username (your Snowflake login, usually your NHS email)" -ForegroundColor DarkGray
    $user = Read-Host "  SNOWFLAKE_USER"

    Write-Host ""
    Write-Host "Warehouse name" -ForegroundColor DarkGray
    Write-Host "  The compute warehouse to run queries against." -ForegroundColor DarkGray
    $warehouse = Read-Host "  SNOWFLAKE_WAREHOUSE"

    Write-Host ""
    Write-Host "Role name" -ForegroundColor DarkGray
    Write-Host "  Your Snowflake role with read access to the OLIDS schemas." -ForegroundColor DarkGray
    $role = Read-Host "  SNOWFLAKE_ROLE"

    Write-Host ""
    Write-Host "Database name" -ForegroundColor DarkGray
    Write-Host "  The ICB-specific OLIDS database (e.g. Data_Store_OLIDS_Alpha)." -ForegroundColor DarkGray
    $database = Read-Host "  SNOWFLAKE_DATABASE"

    # Write .env
    @"
SNOWFLAKE_ACCOUNT=$account
SNOWFLAKE_USER=$user
SNOWFLAKE_WAREHOUSE=$warehouse
SNOWFLAKE_ROLE=$role
SNOWFLAKE_DATABASE=$database
"@ | Set-Content -Path $envFile -Encoding UTF8

    Write-Host ""
    Write-Host "Credentials saved to $envFile" -ForegroundColor Green
}

# --- Step 4: Install/update dependencies ---
Write-Host ""
Write-Host "Installing Python dependencies..." -ForegroundColor Cyan
Push-Location $PSScriptRoot
try {
    uv lock --upgrade
    uv sync
    Write-Host "Dependencies installed." -ForegroundColor Green
} finally {
    Pop-Location
}

# --- Done ---
Write-Host ""
Write-Host "Setup complete." -ForegroundColor Green
Write-Host ""
Write-Host "Run tests with:" -ForegroundColor White
Write-Host "  cd $PSScriptRoot" -ForegroundColor Yellow
Write-Host "  uv run run_tests.py" -ForegroundColor Yellow
Write-Host ""
Write-Host "Note: The first run will open a browser tab for Snowflake SSO authentication." -ForegroundColor DarkGray
Write-Host ""
