# From the PowerShell command line:
# PS C:\github> $PROFILE
# C:\Users\{username}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
#
# Source the latest PowerShell config:
# PS C:\github> . $PROFILE
function eee {
    eza -l -a -h @args
}
function gss {
    git status
}
function gll {
    git log --oneline -10 @args
}