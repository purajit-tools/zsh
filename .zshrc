######################################################################
# 
######################################################################


# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME# tries to resume command of same name
unsetopt BG_NICE # do NOT nice bg commands
setopt CORRECT # command CORRECTION
setopt EXTENDED_HISTORY # puts timestamps in the history
# setopt HASH_CMDS# turns on hashing
#
#setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   notify globdots correct pushdtohome autolist
unsetopt  cdablevars
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash
stty erase '^?'
# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile

TZ="America/New_York"
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=50000
HOSTNAME="`hostname`"
PAGER='less'
    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"
#PS1="[$PR_MAGENTA%n$PR_WHITE@$PR_GREEN%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
#RPS1="$PR_CYAN(%D{%m-%d %H:%M})$PR_NO_COLOR"
#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C

unsetopt ALL_EXPORT
#chpwd
if [[ $TERM == "network" ]];then 
   export TERM=linux
fi
autoload -U compinit
compinit
bindkey '^[OH' beginning-of-line
bindkey "^?" backward-delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:processes-names' command 'ps -axo cmd'
## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

function del() {
  while [ -n "$1" ]; do
    local file=`basename "$1"`
    # Chop trailing '/' if there
    file=${file%/}

    local destination=""

    if [ -e "$HOME/.Trash/$file" ]; then
      # Extract file and extension
      local ext=`expr "$file" : ".*\(\.[^\.]*\)$"`
      local base=${file%$ext}

      # Add a space between base and timestamp
      test -n "$base" && base="$base "

      destination="/$base`date +%H-%M-%S`_$RANDOM$ext"
    fi  

    echo "Moving '$1' to '$HOME/.Trash$destination'"
    mv "$1" "$HOME/.Trash$destination"
    shift
  done
}



source ~/.aliases


export SCIPY_PIL_IMAGE_VIEWER=display

#LD_LIBRARY_PATH=$HOME/lib
#export LD_LIBRARY_PATH

ANDROID_SDK_ROOT=/Users/pareshmg/Downloads/androidSDK

PATH=/Applications/bin:/usr/local/bin:/Users/pareshmg/bin:/usr/texbin:/usr/X11/bin:/Applications/sage:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/opt/bin:/opt/local/bin:~/.cabal/bin


SCIPY_PIL_IMAGE_VIEWER=display



#precmd () {
#    echo -n "\033]1;$USERNAME@$HOST\033]2;$PWD>    - $USERNAME@$HOST
#($status)"
#   }


#enables color in the terminal bash shell export
CLICOLOR=1
#sets up the color scheme for list export
LSCOLORS=gxfxcxdxbxegedabagacad

#enables color for iTerm
#export TERM=xterm-color

LS_COLORS="no=00:fi=00:di=01;36:ln=01;35:so=01;32:pi=40;33:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;31:*.tar=01;31:*.tgz=01;31:*.svgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.svg=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:ow=37;90"
export LS_COLORS

#ZLS_COLORS=LS_COLORS
#export ZLS_COLORS
export ZLSCOLORS="${LS_COLORS}"


### COLORS ###
#fg_green=$'%{\e[0;32m%}'
#fg_blue=$'%{\e[0;34m%}'
#fg_cyan=$'%{\e[0;36m%}'
#fg_red=$'%{\e[0;31m%}'
#fg_brown=$'%{\e[0;33m%}'
#fg_purple=$'%{\e[0;35m%}'

#fg_light_gray=$'%{\e[0;37m%}'
#fg_dark_gray=$'%{\e[1;30m%}'
#fg_light_blue=$'%{\e[1;34m%}'
#fg_light_green=$'%{\e[1;32m%}'
#fg_light_cyan=$'%{\e[1;36m%}' fg_light_red=$'%{\e[1;31m%}'
#fg_light_purple=$'%{\e[1;35m%}'
#fg_no_colour=$'%{\e[0m%}'

#fg_white=$'%{\e[1;37m%}'
#fg_black=$'%{\e[0;30m%}'

if [ $HOSTNAME[1,3] = "pmp" ]; then
    PROMPT=$'[%{\e[1;35m%}%n%{\e[1;37m%}@%{\e[0;32m%}%m%u%{\e[0m%}:%{\e[0;31m%}%2c%{\e[0m%}]%(!.#.$) '
else
    PROMPT=$'[%{\e[1;34m%}%n%{\e[1;37m%}@%{\e[0;31m%}%m%u%{\e[0m%}:%{\e[0;31m%}%2c%{\e[0m%}]%(!.#.$) '

fi

RPROMPT=$'%{\e[0;36m%}(%D{%m-%d %H:%M})%{\e[0m%}'

#source /sw/bin/init.sh
#LDFLAGS="-undefined dynamic_lookup"
export EDITOR=emacsclient

#export XDG_CONFIG_DIRS=/opt/kde4/etc/xdg
#export XDG_DATA_DIRS=/opt/kde4/share:/opt/local/share
#eval `dbus-launch --auto-syntax`


##################################################
## To fix tramp hangs
##################################################

if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst 
    unfunction precmd 
    unfunction preexec
    PS1='$ '
fi
 





