# Lazy-load pyenv - only initialize when actually used
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

_pyenv_lazy_init() {
  local cmd=$1
  shift

  (( ${+functions[pyenv]} )) && unfunction pyenv
  (( ${+functions[python]} )) && unfunction python
  (( ${+functions[pip]} )) && unfunction pip

  eval "$(command pyenv init -)"
  eval "$(command pyenv virtualenv-init -)"

  command $cmd "$@"
}

function pyenv() { _pyenv_lazy_init pyenv "$@" }
function python() { _pyenv_lazy_init python "$@" }
function pip() { _pyenv_lazy_init pip "$@" }
