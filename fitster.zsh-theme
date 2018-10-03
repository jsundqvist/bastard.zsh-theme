# vim:et sts=2 sw=2 ft=zsh
#
# fitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/fitster.zsh-theme
#
# Requires the `git-info` zmodule to be included in the .zimrc file.

prompt_fitster_pwd() {
  pwd=$(pretty_pwd)
  git_root=$(command git rev-parse --show-toplevel 2> /dev/null) && pwd=${pwd#${$(pretty_pwd $git_root):h}/}
  repo=${git_root:t}
  print -n "%F{yellow}${repo}%F{white}${pwd#$repo}"
}

pretty_pwd() {
  local pwd="${1:-${PWD}}"
  pwd="${pwd/#${HOME}/~}"
  print ${pwd}
}

prompt_fitster_git() {
  [[ -n ${git_info} ]] && print -n "${(e)git_info[prompt]}"
}

prompt_fitster_precmd() {
  (( ${+functions[git-info]} )) && git-info
}

prompt_fitster_setup() {
  local prompt_fitster_status='%(?:%F{green}:%F{red})➜ '

  autoload -Uz add-zsh-hook && add-zsh-hook precmd prompt_fitster_precmd

  prompt_opts=(cr percent sp subst)

  zstyle ':zim:git-info' verbose 'yes'
  zstyle ':zim:git-info:branch' format '$([[ %b = master ]] && echo %F{white}%b || echo %F{cyan}%b)'
  zstyle ':zim:git-info:commit' format '%F{blue}%c'
  zstyle ':zim:git-info:clean' format '%F{green}✓'
  zstyle ':zim:git-info:dirty' format '%F{red}✗'
  zstyle ':zim:git-info:behind' format ' %F{magenta}↓'
  zstyle ':zim:git-info:ahead' format ' %F{cyan}↑'
  zstyle ':zim:git-info:diverged' format ' %F{yellow}⇵'
  zstyle ':zim:git-info:action' format ' %F{white}%s'
  zstyle ':zim:git-info:action:bisect' format '←→'
  zstyle ':zim:git-info:action:merge'  format '→←'
  zstyle ':zim:git-info:action:rebase' format '→→'
  zstyle ':zim:git-info:keys' format \
    'prompt' ' %b%c %C%D%B%A%V%s'

  PS1="${prompt_fitster_status}\$(prompt_fitster_pwd)\$(prompt_fitster_git)%f "
  RPS1='%F{8}${SSH_TTY:+%n@%m}%f'
}

prompt_fitster_setup "${@}"
