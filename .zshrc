# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# update PATH
# alias android-studio="~/android-studio/bin/studio.sh"
# export PATH=$HOME/android-studio/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
# export PATH=$PATH:$HOME/.sonar-scanner/bin
export PATH=$PATH:$HOME/nvim/bin
export PATH=$PATH:/opt/gcc-arm/bin
# export PATH=$PATH:$HOME/.cargo/bin

# nvim as default editor
alias vim="nvim"
alias vimc="cd ~/.config/nvim && vim ."
export EDITOR="nvim"

# zsh
alias zshc="vim ~/.zshrc"

# copy
alias copy='xclip -sel clip'

# tmux
alias tmx="tmux"
alias tmxc="nvim ~/.tmux.conf"
alias tmxa="tmux attach"
alias tmxd="tmux detach"
alias tmxk="tmux kill-server"

# directory
alias prj="cd ~/projects" # go to projects folder
alias rust="cd ~/projects/learn/rust" # go to rust folder
alias golang="cd ~/projects/learn/golang/" # go to golang folder
alias zig="cd ~/projects/zig" # go to zig folder
alias notion="cd ~/Desktop/notion" # go to notion folder

# docker
alias dc="docker compose"
function dockstp { # stop all running containers
  if [ -z $(docker ps -q) ] 
    then
      echo "Come on dude! There are no containers running..."
      return
  fi
  echo stopping containers: $(docker ps -q)...
  docker stop $(docker ps -q)
}
function dockrmr { # force remove all running containers
  echo removing running containers $(docker ps -q)...
  docker rm -f $(docker ps -q)
}

# adb
alias tcprev8000="adb reverse tcp:8000 tcp:8000"

# git
alias gits="git status"
alias gitck="git checkout"
alias gitl="git log --oneline"
alias gitsl="git stash list"
alias gitp="git pull"
alias gitnew="git checkout -b"
alias wls="git wkls"
alias addi="git add -i"
alias graph="open -a SourceTree ." # require SourceTree app
alias gitmend="git commit --amend --no-edit" # amend using the existing message
alias lastbranches="git branch --sort=-committerdate"
function gitcm {
  echo -n "Enter the commit message and press [ENTER]: ";
  read commit_message;
  if [ -z "$commit_message" ] 
    then
      echo "Empty commit message..."
      return
  fi
  local curr_branch=$(git branch --show-current);
  print "Adding '$commit_message' to '$curr_branch' branch...";
  git commit -m "$commit_message";
}
gitps() {
  local curr_branch=$(git branch --show-current);
  print "pushing to origin the following branch: $curr_branch ...";
  git push -u origin $curr_branch;
}
gitpsf() {
  local curr_branch=$(git branch --show-current);
  print "force pushing to origin the following branch: $curr_branch ...";
  git push -f -u origin $curr_branch;
}
gitrh() {
  print "Accepting version on HEAD and moving on...";
  git checkout ./src --theirs;
  git add .;
  git rebase --continue;
}
gitrc() {
  print "Moving on rebase...";
  git rebase --continue;
}
gitckmd() {
  local master_exist=$(git branch -l | grep "\smaster");
  if [ -z "$master_exist" ] 
    then
      print "Checking out branch 'main' detached...";
      git checkout -d $(git log --pretty=format:'%h' -n 1 main)
      return
  fi
  print "Checking out branch 'master' detached...";
  git checkout -d $(git log --pretty=format:'%h' -n 1 master)
}
gitundo() {
  if [ -z "$1" ] 
    then
      echo "Specify how many commits to soft undo..."
      return
  fi
  git reset --soft HEAD~$1
  print "$1 commit(s) softly undone...";
}
gitundoh() {
  if [ -z "$1" ] 
    then
      echo "Specify how many commits to HARD undo..."
      return
  fi
  git reset --hard HEAD~$1
  print "$1 commit(s) hardly undone...";
}
# backup current branch (do not checkout)
gitbkp() {
  local new_branch_name=backup/$(git branch --show-current | cut -d '/' -f 2);
  print "Creating '$new_branch_name'...";
  git branch $new_branch_name
  if [ $? -eq 0 ] 
    then
      print "The branch '$new_branch_name' was successfully created!";
  fi
}

# network
function onport {
  lsof -i tcp:$1
}

# process
function killpid {
  kill -9 $1
}
# kill on port
function kop { 
  kill $(lsof -ti:$1)
  print "Killed process on port $1";
}

# kubernetes
alias kbn="kubectl"
alias kfp="kubectl port-forward -n zig-develop db-payment-0 5433:5432"

# arm gcc
# https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
alias arm-gcc="arm-none-eabi-gcc"

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NODE_OPTIONS=--max-old-space-size=8192
# . "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Fix terminal bind Ctrl+A+L
# Remove terminal shortcut Ctrl+L (clear-screen)
# https://unix.stackexchange.com/questions/717315/disable-shortcut-ctrll-which-clears-the-terminal
bindkey -r "^L"
# Bind again for TMUX
tmux bind C-l split-window -h -c "#{pane_current_path}"
