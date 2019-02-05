#!/bin/zsh

git clone --recursive https://github.com/zimfw/zimfw.git ${ZDOTDIR:-${HOME}}/.zim

for template_file in ${ZDOTDIR:-${HOME}}/.zim/templates/*; do
  user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
  cat ${template_file} ${user_file}(.N) > ${user_file}.tmp && mv ${user_file}{.tmp,}
done

source ${ZDOTDIR:-${HOME}}/.zlogin

ln -s $(pwd)/bastard.zsh-theme $HOME/.zim/modules/prompt/functions/prompt_bastard_setup
sed -i.bak "s/zprompt_theme='.*'/zprompt_theme='bastard'/g" $HOME/.zimrc

zsh
