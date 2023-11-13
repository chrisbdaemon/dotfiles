# copied from bash-it framework

# add
alias ga='git add'
alias gall='git add -A'
alias gap='git add -p'
alias gav='git add -v'

# branch
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbl='git branch --list'
alias gbla='git branch --list --all'
alias gblr='git branch --list --remotes'
alias gbm='git branch --move'
alias gbr='git branch --remotes'
alias gbt='git branch --track'
alias gdel='git branch -D'

# for-each-ref
alias gbc='git for-each-ref --format="%(authorname) %09 %(if)%(HEAD)%(then)*%(else)%(refname:short)%(end) %09 %(creatordate)" refs/remotes/ --sort=authorname DESC' # FROM https://stackoverflow.com/a/58623139/10362396

# commit
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcaa='git commit -a --amend -C HEAD' # Add uncommitted and unstaged changes to the last commit
alias gcam='git commit -v -am'
alias gcamd='git commit --amend'
alias gcm='git commit -v -m'
alias gci='git commit --interactive'
alias gcsam='git commit -S -am'

# checkout
alias gcb='git checkout -b'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcobu='git checkout -b ${USER}/'
alias gcom='git checkout $(get_default_branch)'
alias gcpd='git checkout $(get_default_branch); git pull; git branch -D'
alias gct='git checkout --track'

# clone
alias gcl='git clone'

# clean
alias gclean='git clean -fd'

# cherry-pick
alias gcp='git cherry-pick'
alias gcpx='git cherry-pick -x'

# diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git difftool'

# archive
alias gexport='git archive --format zip --output'

# fetch
alias gf='git fetch --all --prune'
alias gft='git fetch --all --prune --tags'
alias gftv='git fetch --all --prune --tags --verbose'
alias gfv='git fetch --all --prune --verbose'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/$(get_default_branch)'
alias gup='git fetch && git rebase'

# log
alias gg='git log --graph --pretty=format:'\''%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset'\'' --abbrev-commit --date=relative'
alias ggf='git log --graph --date=short --pretty=format:'\''%C(auto)%h %Cgreen%an%Creset %Cblue%cd%Creset %C(auto)%d %s'\'''
alias ggs='gg --stat'
alias ggup='git log --branches --not --remotes --no-walk --decorate --oneline' # FROM https://stackoverflow.com/questions/39220870/in-git-list-names-of-branches-with-unpushed-commits
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gnew='git log HEAD@{1}..HEAD@{0}' # Show commits since last pull, see http://blogs.atlassian.com/2014/10/advanced-git-aliases/
alias gwc='git whatchanged'

# ls-files
alias gu='git ls-files . --exclude-standard --others' # Show untracked files
alias glsut='gu'
alias glsum='git diff --name-only --diff-filter=U' # Show unmerged (conflicted) files

# home
alias ghm='cd "$(git rev-parse --show-toplevel)"' # Git home

# merge
alias gm='git merge'

# mv
alias gmv='git mv'

# patch
alias gpatch='git format-patch -1'

# push
alias gp='git push'
alias gpd='git push --delete'
alias gpf='git push --force'
alias gpo='git push origin HEAD'
alias gpom='git push origin $(get_default_branch)'
alias gpu='git push --set-upstream'
alias gpunch='git push --force-with-lease'
alias gpuo='git push --set-upstream origin'
alias gpuoc='git push --set-upstream origin $(git symbolic-ref --short HEAD)'


# pull
alias gl='git pull'
alias glum='git pull upstream $(get_default_branch)'
alias gpl='git pull'
alias gpp='git pull && git push'
alias gpr='git pull --rebase'

# remote
alias gr='git remote'
alias gra='git remote add'
alias grv='git remote -v'

# rm
alias grm='git rm'

# rebase
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grm='git rebase $(get_default_branch)'
alias grmi='git rebase $(get_default_branch) -i'
alias grma='GIT_SEQUENCE_EDITOR=: git rebase  $(get_default_branch) -i --autosquash'
alias gprom='git fetch origin $(get_default_branch) && git rebase origin/$(get_default_branch) && git update-ref refs/heads/$(get_default_branch) origin/$(get_default_branch)' # Rebase with latest remote

# reset
alias gus='git reset HEAD'
alias gpristine='git reset --hard && git clean -dfx'

# status
alias gs='git status'
alias gss='git status -s'

# shortlog
alias gcount='git shortlog -sn'
alias gsl='git shortlog -sn'

# show
alias gsh='git show'

# stash
alias gst='git stash'
alias gstb='git stash branch'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'  # kept due to long-standing usage
alias gstpo='git stash pop' # recommended for it's symmetry with gstpu (push)

## 'stash push' introduced in git v2.13.2
alias gstpu='git stash push'
alias gstpum='git stash push -m'

## 'stash save' deprecated since git v2.16.0, alias is now push
alias gsts='git stash push'
alias gstsm='git stash push -m'

# submodules
alias gsu='git submodule update --init --recursive'

# switch
# these aliases requires git v2.23+
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch $(get_default_branch)'
alias gswt='git switch --track'

# tag
alias gt='git tag'
alias gta='git tag -a'
alias gtd='git tag -d'
alias gtl='git tag -l'

alias gtls='git tag -l | sort -V'

# functions
function gdv() {
	git diff --ignore-all-space "$@" | vim -R -
}

function get_default_branch() {
	if git branch | grep -q '^. main\s*$'; then
		echo main
	else
		echo master
	fi
}

function git_info() {
	if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
		# print informations
		echo "git repo overview"
		echo "-----------------"
		echo

		# print all remotes and thier details
		for remote in $(git remote show); do
			echo "${remote}":
			git remote show "${remote}"
			echo
		done

		# print status of working repo
		echo "status:"
		if [ -n "$(git status -s 2> /dev/null)" ]; then
			git status -s
		else
			echo "working directory is clean"
		fi

		# print at least 5 last log entries
		echo
		echo "log:"
		git log -5 --oneline
		echo

	else
		echo "you're currently not in a git repository"

	fi
}

function git_stats {
	# awesome work from https://github.com/esc/git-stats
	# including some modifications

	if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
		echo "Number of commits per author:"
		git --no-pager shortlog -sn --all
		AUTHORS=$(git shortlog -sn --all | cut -f2 | cut -f1 -d' ')
		LOGOPTS=""
		if [ "$1" == '-w' ]; then
			LOGOPTS="${LOGOPTS} -w"
			shift
		fi
		if [ "$1" == '-M' ]; then
			LOGOPTS="${LOGOPTS} -M"
			shift
		fi
		if [ "$1" == '-C' ]; then
			LOGOPTS="${LOGOPTS} -C --find-copies-harder"
			shift
		fi
		for a in ${AUTHORS}; do
			echo '-------------------'
			echo "Statistics for: ${a}"
			echo -n "Number of files changed: "
			# shellcheck disable=SC2086
			git log ${LOGOPTS} --all --numstat --format="%n" --author="${a}" | cut -f3 | sort -iu | wc -l
			echo -n "Number of lines added: "
			# shellcheck disable=SC2086
			git log ${LOGOPTS} --all --numstat --format="%n" --author="${a}" | cut -f1 | awk '{s+=$1} END {print s}'
			echo -n "Number of lines deleted: "
			# shellcheck disable=SC2086
			git log ${LOGOPTS} --all --numstat --format="%n" --author="${a}" | cut -f2 | awk '{s+=$1} END {print s}'
			echo -n "Number of merges: "
			# shellcheck disable=SC2086
			git log ${LOGOPTS} --all --merges --author="${a}" | grep -c '^commit'
		done
	else
		echo "you're currently not in a git repository"
	fi
}

function gittowork() {
	# param '1: the language/type of the project, used for determining the contents of the .gitignore file'
	# example '$ gittowork java'

	result=$(curl -L "https://www.gitignore.io/api/$1" 2> /dev/null)

	if [[ "${result}" =~ ERROR ]]; then
		echo "Query '$1' has no match. See a list of possible queries with 'gittowork list'"
	elif [[ $1 == list ]]; then
		echo "${result}"
	else
		if [[ -f .gitignore ]]; then
			result=$(grep -v "# Created by http://www.gitignore.io" <<< "${result}")
			echo ".gitignore already exists, appending..."
		fi
		echo "${result}" >> .gitignore
	fi
}

function git-changelog() {
	# ---------------------------------------------------------------
	#  ORIGINAL ANSWER: https://stackoverflow.com/a/2979587/10362396 |
	# ---------------------------------------------------------------
	# about 'Creates the git changelog from one point to another by date'
	# group 'git'
	# example '$ git-changelog origin/master...origin/release [md|txt]'

	if [[ "$1" != *"..."* ]]; then
		echo "Please include the valid 'diff' to make changelog"
		return 1
	fi

	# shellcheck disable=SC2155
	local NEXT=$(date +%F)

	if [[ "$2" == "md" ]]; then
		echo "# CHANGELOG $1"

		# shellcheck disable=SC2162
		git log "$1" --no-merges --format="%cd" --date=short | sort -u -r | while read DATE; do
			echo
			echo "### ${DATE}"
			git log --no-merges --format=" * (%h) %s by [%an](mailto:%ae)" --since="${DATE} 00:00:00" --until="${DATE} 24:00:00"
			NEXT=${DATE}
		done
	else
		echo "CHANGELOG $1"
		echo ----------------------

		# shellcheck disable=SC2162
		git log "$1" --no-merges --format="%cd" --date=short | sort -u -r | while read DATE; do
			echo
			echo "[${DATE}]"
			git log --no-merges --format=" * (%h) %s by %an <%ae>" --since="${DATE} 00:00:00" --until="${DATE} 24:00:00"
			# shellcheck disable=SC2034
			NEXT=${DATE}
		done
	fi
}
