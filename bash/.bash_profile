if [ -f "/etc/bashrc" ]; then
	source /etc/bashrc
fi

for file in $(find ~/.bash_profile.d -type l); do
	source "$file"
done

if [[ -f "$HOME/.bash_profile_local" ]]; then
	source "$HOME/.bash_profile_local"
fi
