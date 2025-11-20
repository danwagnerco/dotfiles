# From the PowerShell command line:
# PS C:\github> $PROFILE
# C:\Users\{username}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
#
# Source the latest PowerShell config:
# PS C:\github> . $PROFILE

# Configure PSReadLine for more intuitive tab autocomplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView  # Shows multiple suggestions
Set-PSReadLineKeyHandler -Key Tab -Function AcceptSuggestion # Tab accepts suggestion

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
