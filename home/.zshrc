# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

alias ls='ls --color=auto'
alias ue5='~/.local/share/lib/Linux_Unreal_Engine_5.4.3/Engine/Binaries/Linux/UnrealEditor'

# End of lines added by compinstall
eval "$(starship init zsh)"
fpath+=${ZDOTDIR:-~}/.zsh_functions
