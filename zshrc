# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##############################################################################
# History Configuration
##############################################################################
eval $(ssh-agent -s)  &>/dev/null
WORKSPACE=$HOME/Documents/Workspace
ssh-add -k $HOME/.keys/github 2>/dev/null
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
export PATH=$PATH:$HOME/.pulumi/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin
export PATH=$PATH:/opt/homebrew/bin
#export PATH=$PATH:/opt/homebrew/bin/aws_completer
#eval `dircolors $HOME/Documents/Workspace/gnome-terminal/dircolors`
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export PULUMI_K8S_SUPPRESS_HELM_HOOK_WARNINGS=true
source $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#source ~/.oh-my-zsh/custom.completion.kube.config
figlet "Welcome" | lolcat -a -s 99
echo -e "\e[32mAny command you execute here will be recorded and \e[1;4;33mheld\e[0m against you" | lolcat -a
##################################Aliases go here##################################
#. $HOME/.asdf/asdf.sh
alias workspace='cd $HOME/Documents/Workspace'
alias ws='cd $HOME/Documents/Workspace'
alias lsp='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
#workspace
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
alias pp='pulumi preview'
alias pu='pulumi up'
alias pr='pulumi refresh'
alias pss='pulumi stack select'
alias mdev='terraform workspace select dev'
alias mhub='terraform workspace select hub'
alias mpre='terraform workspace select pre'
alias mprd='terraform workspace select prd'
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
## pass options to free ##
## Get server cpu info ##
alias cpuinfo='lscpu'
alias weather='curl "wttr.in/ørestad?format=4" && curl "wttr.in/ørestad"'
alias docker=podman
export KIND_EXPERIMENTAL_PROVIDE=podmam
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
nr(){
        message=$1
        display_usage() {
                echo "target required"
        }

        if [  $# -ne 1 ]
                then
                        display_usage
                        return 1
        fi

        npm run "$1"
}
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
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
    kubectl --context ${1} -n ${2} get ${i} --ignore-not-found
  done
}
##################################adding keyskeys##################################

#ssh-add -K ~/.ssh/id_rsa

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

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
#AWS autocomplete
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/opt/homebrew/bin/aws_completer' aws
source <(kubectl completion zsh)
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
