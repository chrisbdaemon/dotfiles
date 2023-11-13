{ command_exists go && go version &> /dev/null; } || return 0

export GOROOT="${GOROOT:-$(go env GOROOT)}"
export GOPATH="${GOPATH:-$(go env GOPATH)}"
