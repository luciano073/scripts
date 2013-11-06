PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

## Set up command history

#append, don't overwrite the history
shopt -s histappend

#ignore common commands
export HISTIGNORE=":pwd:id:uptime:resize:ls:clear:history:"

#ignore duplicate entries
export HISTCONTROL=ignoredups

#Aliases
# alias subl="sublime"
alias la="ls -a"
alias ll="ls -lh"

# Personal functions
ps1_rails()
{
	rails=$(rails -v  2> /dev/null) || return 0
	# rails=${rails#* }
	printf "\033[1;33m[$rails]"
}

ps1_ruby()
{
	ruby=$(ruby -e "print RUBY_VERSION" 2>/dev/null) || return 0
	printf "\033[1;32m[Ruby $ruby] "
}

ps1_git()
{
	branch=$(git symbolic-ref -q HEAD 2>/dev/null) || return 0 # Not in git repo.
  branch=${branch##refs/heads/}

  printf "\033[1;31m[git:$branch]"
}

ps1_rvm()
{
	gemset=$(~/.rvm/bin/rvm-prompt g 2>&-) || return 0
	if [ "$gemset" = '' ]; then
		return 0
	else
		printf "\033[1;35m[gemset:$gemset]"
	fi
}

subl() { sublime "$@" & }

export EDITOR=sublime