#!/bin/bash

case "$-" in
    *i*) # shell is interactive
        BASH_COMPLETION_SH="$HOME/.bash_completion_sh/etc/profile.d/bash_completion.sh"
        [[ $PS1 && -f "$BASH_COMPLETION_SH" ]] && \
            source $BASH_COMPLETION_SH;

        source $HOME/.bash_map

        source $HOME/.bash_environment

        source $HOME/.bash_alias

        source $HOME/.bash_functions

        source $HOME/.bash_terminal

        source $HOME/.bash_prompt

        if [ -f $HOME/.bash_local ]; then
            source $HOME/.bash_local
        fi

        if  [ -z "$SSH_TTY" ]           && \
            [ -z "$SSH_CONNECTION" ]    && \
            [ -z "$SSH_CLIENT" ]        && \
            [ -n "$DISPLAY" ]           && \
            [ -z "$TMUX"  ]; then
            tmux
        fi

        ;;
    *) # shell is not interactive
    ;;
esac

