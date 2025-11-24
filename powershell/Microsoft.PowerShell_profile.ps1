# From the PowerShell command line:
# PS C:\github> $PROFILE
# C:\Users\{username}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
#
# Source the latest PowerShell config:
# PS C:\github> . $PROFILE

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

