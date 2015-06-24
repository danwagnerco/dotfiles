# Home laptop
alias gvim='/c/Users/danie_000/vim/vim74/gvim.exe'
alias vim='/c/Users/danie_000/vim/vim74/vim.exe'

function gl {
        git log -10 --pretty=format:'%C(yellow)%h %C(red)%cr %C(green)%cn %C(white)%s'
}
