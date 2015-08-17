# Home laptop aliases
alias gvim='/c/Users/danie_000/vim/vim74/gvim.exe'
alias vim='/c/Users/danie_000/vim/vim74/vim.exe'
alias ls='ls -hF --color'
alias ZZ='exit'
alias gs='git status'

# Home laptop functions
function gl () {
        if [ -z "$1" ]
        then
                git log -10 --pretty=format:'%C(yellow)%h %C(red)%cr %C(green)%cn %C(white)%s'
        else
                git log -$1 --pretty=format:'%C(yellow)%h %C(red)%cr %C(green)%cn %C(white)%s'
        fi
}

# Home laptop PATH
PATH=$PATH:c/users/danie_000/Anaconda3/Scripts
