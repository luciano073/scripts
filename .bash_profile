source ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*



#Set PS1 variable


# PS1='\[\033[33;1m\][$(rails -v  2> /dev/null | cut -d " " -f 2 | tr "\n" "#")$(ruby -e "print RUBY_VERSION" 2>/dev/null)] \[\033[01;36m\][\w] $(ps1_git) $(ps1_rvm)\[\033[00m\]\n\$ '
PS1='$(ps1_git)$(ps1_rvm)$(ps1_rails)$(ps1_ruby)\[\033[01;36m\][\w]\[\033[00m\]\n\$ '


