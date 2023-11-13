command_exists pyenv \
	|| [[ -n "$PYENV_ROOT" && -x "$PYENV_ROOT/bin/pyenv" ]] \
	|| [[ -x "$HOME/.pyenv/bin/pyenv" ]] \
	|| return 0

export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"

if ! command_exists pyenv && [[ -x "$PYENV_ROOT/bin/pyenv" ]]; then
	pathmunge "$PYENV_ROOT/bin"
fi

pathmunge "$PYENV_ROOT/shims"
eval "$(pyenv init - bash)"

if pyenv virtualenv-init - &> /dev/null; then
	eval "$(pyenv virtualenv-init - bash)"
fi
