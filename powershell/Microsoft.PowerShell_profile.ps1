# Import modules
Import-Module posh-git

# Disable posh-git's default prompt components (we're building our own)
$GitPromptSettings.DefaultPromptPath = ''
$GitPromptSettings.DefaultPromptPrefix = ''
$GitPromptSettings.DefaultPromptSuffix = ''
$GitPromptSettings.DefaultPromptBeforeSuffix = ''
$GitPromptSettings.DefaultPromptWriteStatusFirst = $false

# Configure posh-git git status display
$GitPromptSettings.EnableFileStatus = $true
$GitPromptSettings.EnableStashStatus = $true
$GitPromptSettings.ShowStatusWhenZero = $false
$GitPromptSettings.AutoRefreshIndex = $true
$GitPromptSettings.BeforeStatus = "["
$GitPromptSettings.AfterStatus = "]"
$GitPromptSettings.BranchBehindAndAheadDisplay = "Compact"
$GitPromptSettings.RepositoriesInWhichToDisableFileStatus = @()

# Prevent Python venv from modifying the prompt (we handle it ourselves)
$env:VIRTUAL_ENV_DISABLE_PROMPT = "1"

# Configure PSReadLine for intuitive autocomplete with both history and path completion
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

# Key bindings for prediction navigation
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete            # Tab does path/command completion
Set-PSReadLineKeyHandler -Key DownArrow -Function NextHistory       # Down arrow cycles through ListView
Set-PSReadLineKeyHandler -Key UpArrow -Function PreviousHistory     # Up arrow cycles through ListView  
Set-PSReadLineKeyHandler -Key RightArrow -Function AcceptSuggestion # Right arrow accepts the top prediction
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptSuggestion   # Alternative: Ctrl+F accepts prediction

# Colors
Set-PSReadLineOption -Colors @{
    InlinePrediction = "#8A8A8A"
    Command = "Yellow"
    ListPrediction = "Cyan"  # Color for ListView items
}

# Convenience keyboard shortcuts
function eee {
    eza -l -a -h @args
}
function etree {
    param([int]$Depth)
    
    $baseArgs = '-l', '-a', '-h', '--no-permissions', '--no-filesize', '--no-user', '--no-time', '--no-git', '--tree', '--git-ignore', '--ignore-glob=.git', '--ignore-glob=.venv'
    
    if ($Depth -gt 0) {
        eza @baseArgs --level=$Depth
    } else {
        eza @baseArgs
    }
}
function gss {
    git status
}
function gll {
    git log --oneline -10 @args
}

function pea {
    # Poetry Environment Activate
    $activateCommand = poetry env activate
    if ($activateCommand) {
        Invoke-Expression $activateCommand
    } else {
        Write-Host "No Poetry virtual environment found in this project" -ForegroundColor Red
    }
}

function ped {
    # Poetry Environment Deactivate
    # The 'deactivate' function is injected into the shell by the activation script
    if (Get-Command deactivate -ErrorAction SilentlyContinue) {
        deactivate
    } else {
        Write-Host "No active virtual environment to deactivate" -ForegroundColor Yellow
    }
}

# Custom multi-line prompt
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Line 1A: blank line before prompt for visual separation
    Write-Host ""
    
    # Line 2A: Current Directory (last 3 segments)
    $currentPath = $executionContext.SessionState.Path.CurrentLocation.Path
    $pathParts = $currentPath.Split([IO.Path]::DirectorySeparatorChar)
    $displayPath = if ($pathParts.Count -gt 3) {
        "...\" + ($pathParts[-3..-1] -join '\')
    } else {
        $currentPath
    }
    Write-Host $displayPath -NoNewline -ForegroundColor Cyan
    
    # Line 2B: Virtual Environment (if active)
    if ($env:VIRTUAL_ENV) {
        $venvLeaf = Split-Path $env:VIRTUAL_ENV -Leaf
        if ($venvLeaf -eq '.venv') {
            # uv-style: .venv inside project folder, show project name
            $venvName = Split-Path (Split-Path $env:VIRTUAL_ENV -Parent) -Leaf
        } else {
            # poetry-style: descriptive venv name, use as-is
            $venvName = $venvLeaf
        }
        Write-Host " ($venvName)" -NoNewline -ForegroundColor Green
    }

    # Line 2C: Git Status (using posh-git) - capture and display inline
    if (Get-Command Write-VcsStatus -ErrorAction SilentlyContinue) {
        $gitStatus = & $GitPromptScriptBlock
        if ($gitStatus) {
            Write-Host "$gitStatus" -NoNewline
        }
    }
    
    # Line 3: Prompt character
    Write-Host ""  # New line
    Write-Host ">" -NoNewline -ForegroundColor Yellow
    
    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
}
