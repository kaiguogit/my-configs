# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/kguo/.zsh/completions:"* ]]; then export FPATH="/home/kguo/.zsh/completions:$FPATH"; fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/kguo/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zoxide zsh-autosuggestions web-search copypath copyfile copybuffer dirhistory zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
#
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Dont let ctrl-d exit shell
set -o ignoreeof


alias g="git"
alias gl="gitui"
alias fos="cd ~/build/fos/worktree"
alias fgtip='fgtdev conf set fortigate'
#alias gw='grunt watch'
#alias yw='fos-yarn run watch-upload'
alias lg='lazygit'
alias nw='fos-npm run watch'
alias ns='fos-npm run serve'
alias nl='fos-npm run lint-fix'
alias nb='fos-npm run build'
alias note='vim ~/worklog/notes'
alias conf100d='./Configure -m FGT_100D -d y'
alias confvm='./Configure -m FGT_VM64_KVM -G -d y -v $(basename $PWD)'
alias makevm='confvm && mi12'
alias conf101e='./Configure -m FGT_101E -d y'
alias make101e='conf101e && mi12'
alias prepare_gui="make -sj12 kernel_config prepare migadmin-json-schema migadmin-build"
alias conf100f='./Configure -m FGT_100F -d y'
alias make100f='conf100f && mi12'
alias mi='bear make CONFIG_OPT=no -sj$(nproc) image'
alias makehttpsd='make init -sj12 && fos-dev dae httpsd'
alias makeauthd='make init -sj12 && fos-dev dae http_authd'
alias makecmdb='make init -sj12 && fos-dev dae cmdbsvr'
alias mi8='bear make CONFIG_OPT=no -sj8 image'
alias mi12='bear make CONFIG_OPT=no -sj12 image'
alias mcmdb='fgtdev df && make -sj4 init && fgtdev dae cmdbsvr'
alias mhttp='fgtdev df && make -sj4 init && fgtdev dae httpsd'
alias gti='git'
alias glg='git lg'
alias fix_image='make migadmin-json-schema -sj$(nproc) && cd migadmin/pkg/fos-schema-types && fos-npm run build && cd ../fos-common && fos-npm run build && cd ../report-runner && fos-npm run build && cd ../../..'
alias vpn='sudo /home/kguo/Downloads/forticlientsslvpn/64bit/forticlientsslvpn'
alias ifconfig='ip -c a'
alias dirs="dirs -v"
alias gs="git status"
alias gd="git diff"
alias r="source ranger"
alias vim="nvim"
alias fd="fdfind"
alias rsync="rsync -auhvxPAXW --info=progress2"
alias mount_nfs="sudo mount 10.50.50.200:/mnt/Volume1/Share/backup ~/nfs_share"
alias vpn_con="/opt/forticlient/forticlient-cli vpn connect \"SSLVPN Vancouver\" --user=kguo --password --save-password"
alias vpn_dis="/opt/forticlient/forticlient-cli vpn disconnect \"SSLVPN Vancouver\""
alias vpn_status="/opt/forticlient/forticlient-cli vpn status"
alias replace_caplock="/bin/bash -c \"/usr/bin/setxkbmap -option ctrl:nocaps && /usr/bin/xcape -e 'Control_L=Escape'\""
alias restore_caplock="/usr/bin/setxkbmap -option"
alias build="fos-npx nx run-many --target build --projects"
alias lint-fix="fos-npm run lint-fix"
alias watch_nx="npx nx watch --all -- echo \$NX_PROJECT_NAME \$NX_FILE_CHANGES"


source ~/build/devtools/fos/fos_node_env

export USESUDO=$(which sudo)
export FORTIPKG=$HOME/fortipkg
export PATH="$HOME/bin/:$PATH"
export PATH="$PATH:/usr/java/jre1.8.0_261/bin"
export PATH="$PATH:/home/kguo/bin/mongodb-linux-x86_64-ubuntu2004-4.4.3/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/home/kguo/build/devtools/git/contrib"

export CHROME_BIN=/usr/bin/google-chrome
export CHROMIUM_BIN=/usr/bin/google-chrome
export CLICKUP_TOKEN=pk_54677030_HFWHP1FJKBMF6E28AL7X4LKAA2QKZNUW
export SASE_CHECKOUT_PATH=/home/kguo/build/sase/fos-gui-light
export SASE_BIND_PORT=44308
export FORTISASE_HARBOR_PASSWORD=dBYa2ZueeK2B8wMhUJ6lcPRu6U4zXeQX

# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
#     export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
# else
#     export VISUAL="nvim"
#     export EDITOR="nvim"
# fi
#
# # nvim remote
# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
# fi

# Generated for envman. Do not edit.
# [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions
export TMOUT=0
# Install npm dev dependencie
ANGULAR_VERSION=14

# Node/NPM
if [ -f "$HOME/.nvm/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    source $NVM_DIR/nvm.sh
    if [ -f "$NVM_DIR/bash_completion" ]; then
        source $NVM_DIR/bash_completion
    fi
    if [ -f ".nvmrc" ]; then
        nvm use --silent
    fi
fi

# . "/home/kguo/.deno/env"

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - bash)"


# pnpm
# export PNPM_HOME="/home/kguo/.local/share/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end
