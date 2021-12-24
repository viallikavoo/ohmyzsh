##############################################################################
# History Configuration
##############################################################################
figlet "Welcome" | lolcat -a -s 99
echo -e "\e[32mAny command you execute here will be recorded and \e[1;4;33mheld\e[0m against you" | lolcat -a
eval $(ssh-agent -s)  &>/dev/null
WORKSPACE=$HOME/Documents/Workspace
ssh-add -k $WORKSPACE/github 2>/dev/null
ssh-add -k $WORKSPACE/vmware-k8s 2>/dev/null
#ssh-add -K $HOME/Documents/Workspace/Stash
HISTSIZE=15000              #How many lines of history to keep in memory
HISTFILE=~/zsh_history/zsh_history     #Where to save history to disk
SAVEHIST=50000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt appendhistory     #Append history to the history file (no overwriting)
setopt sharehistory      #Share history across terminals
setopt incappendhistory  #Immediately append to the history file, not just when a term is kill
autoload zcalc
#stty -ixon
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export KOPS_STATE_STORE=s3://kops.infra.core.siteimprove.systems
#eval `dircolors $HOME/Documents/Workspace/gnome-terminal/dircolors`
source $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.oh-my-zsh/custom.completion.kube.config
##################################Aliases go here##################################
. $HOME/.asdf/asdf.sh
alias workspace='cd $HOME/Documents/Workspace'
alias ws='cd $HOME/Documents/Workspace'
workspace
#ls -d */| xargs -P10 -I{} git -C {} pull
alias ph='git push'
alias pl='git pull'
alias ss='git status'
#alias myip='curl http://api.ipify.org'
alias downloads='cd $HOME/Downloads'
alias cd..='cd ..'
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ports='netstat -tulanp'
# become root #
alias root='sudo -i'
alias su='sudo -i'
# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='export COMMIT_TITLE=$(date)_$(hostname) && cd ~/zsh_history && git pull && git add . && git commit -am "$COMMIT_TITLE" && git push && sudo /sbin/shutdown'
alias vpnon='nmcli con up id "SiteImprove L2TP VPN"'
alias vpnoff='nmcli con down id "SiteImprove L2TP VPN"'
## pass options to free ##
alias output_laptop_speaker='pactl set-default-sink "alsa_output.pci-0000_00_1f.3.analog-stereo"'
alias output_jabra_headphone='pactl set-default-sink "alsa_output.usb-0b0e_Jabra_Link_380_3050750A48A6-00.iec958-stereo"'
alias output_ueboom='pacmd set-default-sink "bluez_sink.88_C6_26_9C_D0_6D.a2dp_sink"'
## Get server cpu info ##
alias cpuinfo='lscpu'
alias weather='curl "wttr.in/ørestad?format=4" && curl "wttr.in/ørestad"'
##################################Functions##################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

gitcp(){
        message=$1
        display_usage() {
                echo "mesasge required"
        }

        if [  $# -ne 1 ]
                then
                        display_usage
                        return 1
        fi

        git commit -am "$1"
	git push
}

argome(){
	argocd login argocd.stmprv.io --password yAg9NKRAH3BoggtCQhWGXphHQWqeAM3B --username admin
	baseurl=https://argocd.stmprv.io/applications/
	argocd app list -o name | grep $1 | while read -r line; do chromium "$baseurl$line"; done
}

gch(){
        branch=$1
        display_usage() {
                echo "branch required"
        }

        if [  $# -ne 1 ]
                then
                        display_usage
                        return 1
        fi
	echo $1
        git checkout "$1"
}

awslogin(){
	profile=$1
	aws-adfs login --profile $1
	export AWS_PROFILE=$1
}

#fzfhelp(){
#echo "wild: Exact match, return items that include wild.\n^music: Prefix-exact-match, return items that start with music.\n.mp3$: Suffix-exact-match, return items that end with .mp3.\n!fire: Inverse-exact-match, return items that do not include fire.\n!^music: Inverse-prefix-exact-match, return items that do not start with music.\n!.mp3$: Inverse-suffix-exact-match, return items that do not end with .mp3."
#}


awsclear(){
	eval $(aws-clear-role)
}

kubectlgetall(){
  for i in $(kubectl --context ${1} api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl --context ${1} -n ${2} get --ignore-not-found ${i}
  done
}
##################################adding keyskeys##################################

#ssh-add -K ~/.ssh/id_rsa

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  history-substring-search
  sudo
)
source $ZSH/oh-my-zsh.sh 

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
