# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git web-search)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# Variables
SAVEHIST=100
HISTFILE=~/.zsh_history
EDITOR=nvim

###################################################

# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


###############
#### PROMT ####
###############

### Powerlevel10k ###
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
# source /home/linuxbrew/.linuxbrew/share/powerlevel10k/powerlevel10k.zsh-theme
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#####################

#### Starship ####
eval "$(starship init zsh)"
##################

#### oh-my-posh ####
# eval "$(oh-my-posh init zsh)"
####################


##############
#### END #####
##############


# zsh-autosuggestions plugin
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting plugin
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# eza(better ls)
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"


# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}


# alias for zoxide(better cd)
eval "$(zoxide init zsh)"
alias cd="z"


## case insensitive path-completion
# autoload -Uz +X compinit && compinit
#
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion:*' menu select

# bun completions
[ -s "/home/ashvinjangid/.bun/_bun" ] && source "/home/ashvinjangid/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH


# pywal theme for all new terminals sessions
# (cat ~/.cache/wal/sequences &)


# aliases
alias v="nvim"
alias tmux-sessionizer="~/.local/bin/scripts/tmux-sessionizer"
alias gl="git --no-pager log --oneline --graph --all --decorate -n 10"

# webi
source ~/.config/envman/PATH.env

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
export PATH=$PATH:$HOME/go/bin

# spicetify
export PATH=$PATH:/home/ashvinjangid/.spicetify

# nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
