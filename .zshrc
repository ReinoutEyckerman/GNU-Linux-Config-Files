# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Functions
function set_title(){
    echo -ne "\033];$(hostname): $(pwd)\007"
}
##Variables
export TERM="xterm-256color"
export SHELL="/bin/zsh"
export EDITOR="vim"

# Fix Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE
export ZSH_CUSTOM=$ZSH/custom


#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'	

# color formatting for man pages
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;36m'     # begin blink
export LESS_TERMCAP_so=$'\e[1;33;44m'  # begin reverse video
export LESS_TERMCAP_us=$'\e[1;37m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

export MANPAGER='less -s -M -R +Gg'

export LS_OPTIONS='--color=auto'

# Common aliases
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"
alias ls="ls $LS_OPTIONS -hFtr"
alias ll="ls $LS_OPTIONS -lAhFtr"
alias ccat="pygmentize -O style=monokai -f 256 -g"
alias dig="dig +nocmd any +multiline +noall +answer"

disable -r time       # disable shell reserved word
alias time='time -p ' # -p for POSIX output



# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update
    zplug "zplug/zplug", hook-build:"zplug --self-manage"
fi
source ~/.zplug/init.zsh
zplug romkatv/powerlevel10k, as:theme, depth:1 to ~/.zshrc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# better diffs
zplug "zdharma/zsh-diff-so-fancy"

# Git calendar
zplug "k4rthik/git-cal", as:command

#CLI fuzzy finder
zplug "junegunn/fzf", use:"shell/*.zsh"

#Enhanced CD
zplug "b4b4r07/enhancd", use:init.sh

# thefuck / escesc sudo
zplug "laggardkernel/zsh-thefuck", as:plugin

#Inline highlighting
zplug "zdharma/fast-syntax-highlighting"

#Directory colors
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin
zplug "pinelibg/dircolors-solarized-zsh"

## OH MY ZSH
# print image to terminal
zplug "plugins/catimg",            from:oh-my-zsh
#Colored man pages
zplug "plugins/colored-man-pages", from:oh-my-zsh
# ccat: Colored cat
zplug "plugins/colorize",          from:oh-my-zsh
#Prints package containing command if not found
zplug "plugins/command-not-found", from:oh-my-zsh
# Common aliases
zplug "plugins/common-aliases",    from:oh-my-zsh
# Copy current dir to clipboard
zplug "plugins/copydir",           from:oh-my-zsh
# Copy file to clipboard
zplug "plugins/copyfile",          from:oh-my-zsh
#Cycle through dirs with ctrl-shift-left/right
zplug "plugins/dircycle",          from:oh-my-zsh
#Extract compressed files
zplug "plugins/extract",           from:oh-my-zsh
# Prints history
zplug "plugins/history",           from:oh-my-zsh

zplug "plugins/tmux",              from:oh-my-zsh
zplug "plugins/tmuxinator",        from:oh-my-zsh
zplug "plugins/urltools",          from:oh-my-zsh
zplug "plugins/web-search",        from:oh-my-zsh

zplug "plugins/git",               from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/golang",            from:oh-my-zsh, if:"(( $+commands[go] ))"
zplug "plugins/pip",               from:oh-my-zsh, if:"(( $+commands[pip] ))"
zplug "plugins/sudo",              from:oh-my-zsh, if:"(( $+commands[sudo] ))"
zplug "plugins/gpg-agent",         from:oh-my-zsh, if:"(( $+commands[gpg-agent] ))"
zplug "plugins/systemd",           from:oh-my-zsh, if:"(( $+commands[systemctl] ))"
zplug "plugins/docker",            from:oh-my-zsh, if:"(( $+commands[docker] ))"
zplug "plugins/docker-compose",    from:oh-my-zsh, if:"(( $+commands[docker-compose] ))"
zplug "plugins/terraform",         from:oh-my-zsh, if:"(( $+commands[terraform] ))"
zplug "plugins/vagrant",           from:oh-my-zsh, if:"(( $+commands[vagrant] ))"

zplug "djui/alias-tips"
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
# zsh-syntax-highlighting must be loaded after executing compinit command
# and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

## Options
autoload -Uz add-zsh-hook
setopt autocd                   # Allow changing directories without `cd`
setopt append_history           # Dont overwrite history
setopt auto_param_slash         # if completed parameter is a directory, add a trailing slash
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt COMPLETE_IN_WORD        # complete from the cursor rather than from the end of the word
setopt extended_history         # Also record time and duration of commands.
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.
setopt hist_ignore_space        # Ignore commands that start with space.
setopt HIST_VERIFY             # if a command triggers history expansion, show it instead of running
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt prompt_subst
setopt pushd_ignore_dups
setopt PATH_DIRS               # perform path search even on command names with slashes
setopt share_history            # Share history between multiple shells

function history() {
    #rg --smart-case --colors 'path:fg:yellow' --vimgrep -o '[^;]*$' ~/.zsh_history
    #rg --smart-case --vimgrep -p -o '[^;]*$' ~/.zsh_history
    rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" --vimgrep -o '[^;]*$' ~/.zsh_history
}

# Watching other users
#WATCHFMT="%n %a %l from %m at %t."
watch=(notme)         # Report login/logout events for everybody except ourself.
LOGCHECK=60           # Time (seconds) between checks for login/logout activity.
REPORTTIME=5          # Display usage statistics for commands running > 5 sec.

# Key timeout and character sequences
KEYTIMEOUT=1
WORDCHARS='*?_-[]~=./&;!#$%^(){}<>'

## Startup
#
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
DIRCOLORS_SOLARIZED_ZSH_THEME="256dark"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

if zplug check "junegunn/fzf-bin"; then
    export FZF_DEFAULT_OPTS="--height 40% --reverse --border --inline-info --color=dark,bg+:235,hl+:10,pointer:5"
fi

if zplug check "zsh-users/zsh-history-substring-search"; then
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey "^[[1;5A" history-substring-search-up
    bindkey "^[[1;5B" history-substring-search-down
fi

if zplug check "zsh-users/zsh-syntax-highlighting"; then
    typeset -gA ZSH_HIGHLIGHT_STYLES ZSH_HIGHLIGHT_PATTERNS

    ZSH_HIGHLIGHT_STYLES[cursor]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=none
    ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=070
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=070
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
    ZSH_HIGHLIGHT_STYLES[assign]=none

    ## Override highlighter colors
    #ZSH_HIGHLIGHT_STYLES[default]=none
    #ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
    #ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
    #ZSH_HIGHLIGHT_STYLES[alias]=fg=white,bold
    #ZSH_HIGHLIGHT_STYLES[builtin]=fg=white,bold
    #ZSH_HIGHLIGHT_STYLES[function]=fg=white,bold
    #ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
    #ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
    #ZSH_HIGHLIGHT_STYLES[commandseparator]=none
    #ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
    #ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
    #ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
    #ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
    ##ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ##ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    #ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=070
    #ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=070
    #ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    #ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
    #ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
    #ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
    #ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
    #ZSH_HIGHLIGHT_STYLES[assign]=none

    #ZSH_HIGHLIGHT_STYLES[path]='fg=underline'
    #ZSH_HIGHLIGHT_STYLES[default]='none'
    #ZSH_HIGHLIGHT_STYLES[cursor]='fg=yellow'
    #ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
    #ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
    #ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
    #ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
    #ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
    #ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'
    #ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
    #ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
    #ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
    #ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
    #ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=grey,underline'
    #ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=white'
    #ZSH_HIGHLIGHT_STYLES[path_approx]='fg=white'
    #ZSH_HIGHLIGHT_STYLES[globbing]='none'
    #ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
    #ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue,bold'
    #ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue,bold'
    #ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
    #ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=magenta,bold'
    #ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=magenta,bold'
    #ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
    #ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
    #ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
    #ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
    #ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
    #ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
    #ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
    #ZSH_HIGHLIGHT_STYLES[assign]='none'

    ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)
fi

if zplug check "zsh-users/zsh-autosuggestions"; then
    #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=075'
    #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=162'

fi

if zplug check "b4b4r07/enhancd"; then
    ENHANCD_FILTER="fzf:peco:percol"
    ENHANCD_COMMAND="c"
fi

if zplug check "b4b4r07/zsh-history-enhanced"; then
    ZSH_HISTORY_FILE="$HISTFILE"
    ZSH_HISTORY_FILTER="fzf:peco:percol"
    ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
    ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# =============================================================================
#                                 Completions
# =============================================================================
#zstyle ':completion:' completer _complete _match _approximate
#zstyle ':completion:' group-name ''
## Color completion for some items.
##zstyle ':completion:' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:' use-cache true
#zstyle ':completion:' verbose yes
#zstyle ':completion:*:default' menu select=2
#zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
#zstyle ':completion:*:options' description 'yes'

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# case-insensitive (uppercase from lowercase) completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# process completion
#zstyle ':completion:*:processes' command 'ps -au$USER'
#zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# zstyle
zstyle ':completion:*' completer _expand _complete _ignored _approximate
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{yellow}%d%f%u'
#zstyle ':completion:*:*:git:*' script ~/.git-completion.sh
#
zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# case-insensitive (all), partial-word and then substring completion
zstyle ":completion:*" matcher-list \
    "m:{a-zA-Z}={A-Za-z}" \
    "r:|[._-]=* r:|=*" \
    "l:|=* r:|=*"

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

#ZLE_RPROMPT_INDENT=0

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# vim: ft=zsh sw=4 sts=4 et

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
