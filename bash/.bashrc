if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

if [ -f "/etc/bashrc" ]; then
	source /etc/bashrc
fi

for i in aliases functions vars; do
	if [[ -e "$HOME/.$i" ]]; then
		source "$HOME/.$i"
	fi
done

if [[ -f "$HOME/.bashrc_local" ]]; then
	source "$HOME/.bashrc_local"
fi

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_BLUE="\033[0;34m"
COLOR_MAGENTA="\033[0;35m"
COLOR_CYAN="\033[0;36m"
COLOR_RESET="\033[0m"

if [[ -e "$HOME/.pyenv" ]]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi

git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status_flag() {
	local git_status=$(git status 2> /dev/null)
	if [[ ! $git_status =~ "working directory clean" ]]; then
		echo -e '*'
	fi
}

git_prompt_status() {
	local branch=$(git_branch)
	local flag=$(git_status_flag)
	if [[ -n "$branch" ]]; then
		echo "<$branch$flag> "
	fi
}

PROMPT_START="\u\[$COLOR_BLUE\]@\[$COLOR_RESET\]\h "
PROMPT_START+="\[$COLOR_MAGENTA\]::\[$COLOR_RESET\] "
PROMPT_START+="\[$COLOR_GREEN\]\w\[$COLOR_RESET\]"
PROMPT_END="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "
export PS1="$PROMPT_START $PROMPT_END"

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
	GIT_PROMPT_START="$PROMPT_START"
	GIT_PROMPT_END=" $PROMPT_END"
	GIT_PROMPT_ONLY_IN_REPO=1
	source $HOME/.bash-git-prompt/gitprompt.sh
fi
