# vim:et sts=2 sw=2 ft=zsh
#
# bastard theme based on gitster
# https://github.com/zimfw/zimfw/blob/master/modules/prompt/themes/gitster.zsh-theme
#
# Requires the `git-info` zmodule to be included in the .zimrc file.

prompt_bastard_pwd() {
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

prompt_bastard_git() {
  [[ -n ${git_info} ]] && print -n "${(e)git_info[prompt]}"
}

prompt_bastard_precmd() {
  (( ${+functions[git-info]} )) && git-info
}

prompt_bastard_setup() {
  local prompt_bastard_status='$([[ -f /.dockerenv ]] && echo "%(?:%F{blue}:%F{magenta})" || echo "%(?:%F{green}:%F{red})" )➜ '

  autoload -Uz add-zsh-hook && add-zsh-hook precmd prompt_bastard_precmd

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
  zstyle ':zim:git-info:action:cherry-pick' format '→⃝'
  zstyle ':zim:git-info:keys' format \
    'prompt' ' %b%c %C%D%B%A%V%s'

  PS1="${prompt_bastard_status}\$(prompt_bastard_pwd)\$(prompt_bastard_git)%f "
  RPS1='%F{black}%D{%R}'
}

prompt_bastard_setup "${@}"
