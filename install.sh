#!/usr/bin/env zsh

ln -s ${0:a:h}/bastard.zsh-theme $HOME/.zim/modules/bastard
sed -i.bak "s/zprompt_theme='.*'/zprompt_theme='bastard'/g" $HOME/.zimrc

zsh
