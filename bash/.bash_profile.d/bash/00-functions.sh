function pathmunge() {
	# about 'prevent duplicate directories in your PATH variable'
	# group 'helpers'
	# example 'pathmunge /path/to/dir is equivalent to PATH=/path/to/dir:$PATH'
	# example 'pathmunge /path/to/dir after is equivalent to PATH=$PATH:/path/to/dir'

	if [[ -d "${1:-}" && ! $PATH =~ (^|:)"${1}"($|:) ]]; then
		if [[ "${2:-before}" == "after" ]]; then
			export PATH="$PATH:${1}"
		else
			export PATH="${1}:$PATH"
		fi
	fi
}

function command_exists() {
	# _about 'checks for existence of a command'
	# _param '1: command to check'
	# _param '2: (optional) log message to include when command not found'
	# _example '$ _command_exists ls && echo exists'
	# _group 'lib'
	local msg="${2:-Command '$1' does not exist}"
	if type -t "$1" > /dev/null; then
		return 0
	else
		return 1
	fi
}
