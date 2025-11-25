# Import modules
Import-Module posh-git

# Configure posh-git prompt and settings
$GitPromptSettings.EnableFileStatus = $true
$GitPromptSettings.EnableStashStatus = $true
$GitPromptSettings.ShowStatusWhenZero = $false
$GitPromptSettings.AutoRefreshIndex = $true
$GitPromptSettings.BeforeStatus = "["
$GitPromptSettings.AfterStatus = "] "
$GitPromptSettings.DefaultPromptSuffix = ""
$GitPromptSettings.BranchBehindAndAheadDisplay = "Compact"
$GitPromptSettings.RepositoriesInWhichToDisableFileStatus = @()

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
function gss {
    git status
}
function gll {
    git log --oneline -10 @args
}

# Custom multi-line prompt function
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    
    # Line 1: Virtual Environment (if active)
    if ($env:VIRTUAL_ENV) {
        $venvName = Split-Path $env:VIRTUAL_ENV -Leaf
        Write-Host "($venvName) " -NoNewline -ForegroundColor Green
    }
    
    # # Line 1: Current Directory (abbreviated)
    # $currentPath = $executionContext.SessionState.Path.CurrentLocation.Path
    
    # # Option B: Show only last 2 path segments
    # $pathParts = $currentPath.Split([IO.Path]::DirectorySeparatorChar)
    # $displayPath = if ($pathParts.Count -gt 2) {
    #     "...\" + ($pathParts[-2..-1] -join '\')
    # } else {
    #     $currentPath
    # }
    
    Write-Host $displayPath -NoNewline -ForegroundColor Cyan
    
    # Line 1: Git Status (using posh-git) - capture and display inline
    if (Get-Command Write-VcsStatus -ErrorAction SilentlyContinue) {
        $gitStatus = & $GitPromptScriptBlock
        if ($gitStatus) {
            Write-Host " $gitStatus" -NoNewline
        }
    }
    
    # Line 2: Prompt character
    Write-Host ""  # New line
    Write-Host ">" -NoNewline -ForegroundColor Yellow
    
    $global:LASTEXITCODE = $realLASTEXITCODE
    return " "
}
