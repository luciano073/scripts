#!/usr/bin/env bash

cd $HOME
echo '## Set up command history' >> .bashrc
echo >> .bashrc
echo "#append, don't overwrite the history" >> .bashrc
echo "shopt -s histappend" >> .bashrc
echo >> .bashrc
echo "#ignore common commands" >> .bashrc
echo 'export HISTIGNORE=":pwd:id:uptime:resize:ls:clear:history:"' >> .bashrc
echo -e "\n#ignore duplicate entries" >> .bashrc
echo "export HISTCONTROL=ignoredups"

#Set up inputrc
echo "set completion-ignore-case on" >> .inputrc
echo "set bell-style visible" >> .inputrc


