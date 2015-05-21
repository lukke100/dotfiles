#!/bin/bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/git/completion/git-prompt.sh

function SET_TITLE_COMMAND
{
    echo -ne "\033]0;bash (${PWD/$HOME/\~}) - urxvt\007";
}

function PRINT_SEP_BAR {
    # Ensure ${COLUMNS} is set properly
    eval `resize`
    # Write our string
    perl -e '{
        use strict;
        use warnings;

        my $hostname    = `hostname`;
        chomp $hostname;
        my $center_text = " $hostname ";
        my $columns     = '${COLUMNS}';
        my $spaces_side = int($columns/2) - int(length($center_text) / 2);
        my $side_text   = "=" x $spaces_side;

        my $full_text   = $side_text . $center_text . $side_text;
        chop $full_text if (length $full_text) > $columns;

        print $full_text;
    }';
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"

# PS1 is overloaded by __git_ps1 PROMPT_COMMAND
PS2='... '
PS3='> '
PS4='+ '

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Exporting this doesn't seem to work
PROMPT_COMMAND='__git_ps1 "`PRINT_SEP_BAR`\n\w/" " -> "; SET_TITLE_COMMAND'

COLOR_SED='sed s/ex\=[0-9][0-9];[0-9][0-9]:/ex\=0:/'
eval $(dircolors -b | $COLOR_SED)
unset COLOR_SED
alias la="ls -A"
alias ls="ls -hbHL1 --time-style=long-iso --file-type --color=auto --group-directories-first"
alias ll="ls -l"
alias dir="dir --color --time-style=long-iso --group-directories-first"
alias vdir="vdir -A --color --time-style=long-iso --group-directories-first"
alias grep='grep --color=auto'
alias info='info --vi-keys'
EDITOR=vim
VISUAL=vim
PAGER=less
BROWSER=firefox
LESS_TERMCAP_mb=$'\E[01;31m'
LESS_TERMCAP_md=$'\E[01;31m'
LESS_TERMCAP_me=$'\E[0m'
LESS_TERMCAP_se=$'\E[0m'
LESS_TERMCAP_so=$'\E[01;44;33m'
LESS_TERMCAP_ue=$'\E[0m'
LESS_TERMCAP_us=$'\E[01;32m'
LESS="-RXFsi"
LESSHISTFILE='/dev/null'
HISTFILE="$HOME/.cmd_history"
XDG_CONFIG_HOME="$HOME/.config"
GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
HISTFILESIZE=
HISTSIZE=
shopt -s histappend
alias top='htop'

# For mutt
COLORFGBG="default;default"

PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
PERL_MB_OPT="--install_base \"$HOME/perl5\""
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

