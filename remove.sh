#!/bin/sh

rm $HOME/.zim/modules/prompt/functions/prompt_bastard_setup
if [ -f "$HOME/.zimrc.bak" ]; then
    rm $HOME/.zimrc
    mv $HOME/.zimrc.bak $HOME/.zimrc
fi
zsh
