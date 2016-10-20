# Saumon

export TERM="xterm-256color"
export DEFAULT_USER=saumon
export PAGER='less -X'
export MANPAGER='less -X'
export BROWSER='firefox'

export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# case-sensitive completion
export CASE_SENSITIVE="true"

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

export DISPLAY="${DISPLAY:-:0}"

alias vi='vim'



user_commands=(
  list-units is-active status show help list-unit-files
  is-enabled list-jobs show-environment cat)

sudo_commands=(
  start stop reload restart try-restart isolate kill
  reset-failed enable disable reenable preset mask unmask
  link load cancel set-environment unset-environment
  edit)

for c in $user_commands; do; alias sc-$c="systemctl $c"; done
for c in $sudo_commands; do; alias sc-$c="sudo systemctl $c"; done




up() {
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed -e 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

prepare_repo() {
	blih repository create $1
	blih repository setacl $1 ramassage-tek r
}


function extract() {
  if [ -f "$1" ] ; then
    local filename=$(basename "$1")
    local foldername="${filename%%.*}"
    local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
    local didfolderexist=false
    if [ -d "$foldername" ]; then
      didfolderexist=true
      read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
      echo
      if [[ $REPLY =~ ^[Nn]$ ]]; then
        return
      fi
    fi
    mkdir -p "$foldername" && cd "$foldername"
    case $1 in
      *.tar.bz2) tar xjf "$fullpath" ;;
      *.tar.gz) tar xzf "$fullpath" ;;
      *.tar.xz) tar Jxvf "$fullpath" ;;
      *.tar.Z) tar xzf "$fullpath" ;;
      *.tar) tar xf "$fullpath" ;;
      *.taz) tar xzf "$fullpath" ;;
      *.tb2) tar xjf "$fullpath" ;;
      *.tbz) tar xjf "$fullpath" ;;
      *.tbz2) tar xjf "$fullpath" ;;
      *.tgz) tar xzf "$fullpath" ;;
      *.txz) tar Jxvf "$fullpath" ;;
      *.zip) unzip "$fullpath" ;;
      *) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}




cx() { chmod +x $* }


# Colored man pages

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		GROFF_NO_SGR=1 \
		PAGER="less -X" \
		_NROFF_U=1 \
			man "$@"
}


mr_clean() {
	find -name "*~" -delete -o -name "#*#" -delete -o -name "a.out" -delete
}

update_libmy() {
	cd /data/pool/libmy/ && rm *.o;
	cd /data/pool/libmy/ && gcc -c -Wall -Wextra *.c && ar rc libmy.a *.o && rm *.o
}


alias nettoyer_les_fichiers_de_merde_de_emacs_de_merde='mr_clean'

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
unalias sl

alias -g ls='ls --group-directories-first --color=auto -ph'

alias l='ls'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -lA'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias maj='sudo zypper update'
alias install='sudo zypper install'
alias remove='sudo zypper remove'
alias tree='tree -C'

alias mv='mv -v'
alias rm='rm -I -v'
alias cp='cp -v'
alias ln='ln -v'

alias e='expr'
alias calc='bc'
alias u='up && ls'
alias fucking='sudo'
alias temp='cat /sys/class/thermal/thermal_zone0/temp'
alias week='date +%V'
alias update-grub='sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
alias song='curl http://cigix.noip.me/update.php; echo'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias diskspace_report='df -P -kHl'
# alias riplaco='ping 8.8.8.8 | grep -E --only-match --color=never "[0-9\.]+ ms"'
alias riplaco='wpa_gui'
# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'
alias ff='find $1 -type f -name'

alias whyami='echo "Ask your mom";:'
alias putain='echo "Wesh ta gueule";:'
alias bonsoir='echo "Bonsoir.";:'
alias mama='echo "Mama ?";:'
alias wtf='dmesg'
alias rtfm='man'
alias ma,='man'
alias bite='echo "owi bit";:'

alias apt-get='echo "pauvre bite";:'
alias pacman='echo "pauvre cul";:'
alias gti='echo "pauvre merde\n";git'

# music play/pause
alias pp="mpc toggle"


# vimrc editing
alias ve='vim ~/.vimrc'

# zsh profile editing
alias ze='vim ~/.zshrc'


alias :q='exit'

c() { cd "$@" && ls; }

# Enable aliases to be sudo’ed
alias sudo='sudo '


alias t='tree'
alias pls='sl'

# EPITECH

ulimit -c 0
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/heimdal/bin:/usr/heimdal/sbin"
export EDITOR='emacs'
export HISTSIZE=1000
export MAIL="/u/all/${USER}/mail/${USER}"
export SAVEHIST=1000
export WATCH='all'
alias j='jobs'
alias emacs='emacs -nw'
alias ne='emacs'

export TEKUSER="maxime.louet@epitech.eu"

### C Graphical Programming Environement Variable
export LIBRARY_PATH=$LIBRARY_PATH:/home/saumon/.graph_programming/lib
export LD_LIBRARY_PATH=$LIBRARY_PATH:/home/saumon/.graph_programming/lib
export CPATH=$CPATH:/home/saumon/.graph_programming/include
