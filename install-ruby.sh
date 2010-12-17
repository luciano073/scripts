#!/bin/bash
#
# install-ruby.sh
#
# Descricao: Instala pacotes da linguagem ruby (versao >1.8.7) e a ferramenta de linha de comando Ruby Version Manager (rvm)
#
# Autor    :
#
# Versao 0.1
#
# Data    : Dezembro/2010
#------------------------------------------------------
echo -e '\033[32m ---> Instalando ruby e pacotes extras...\033[m\n'

sudo apt install build-essential subversion git-core vim curl ruby ruby-dev rubygems rake irb zlib1g-dev libreadline5-dev libssl-dev sqlite3 libsqlite3-dev

cd "$HOME"
echo -e '\033[32m ---> Instalando rvm...\033[m\n'


bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

CONFIG_BASH="[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm"
echo "$CONFIG_BASH" >> "$HOME/.bashrc"

CONFIG_BASH="export PS1='\w `~/.rvm/bin/rvm-prompt i v g` `git branch 2> /dev/null | grep -e ^* | sed -e s/^\\\\\*\ \(.+\)$/\(\\\\1\)\ /`\n\[\033[37m\]\$ \[\033[00m\] '"
echo "$CONFIG_BASH" >> "$HOME/.bashrc"

sudo apt-get install bison openssl libreadline5 libreadline-dev libreadline6-dev libxml2-dev autoconf sun-java6-bin sun-java6-jre sun-java6-jdk icedtea6-plugin

echo -e '\033[32m ---> Instalando pacotes rvm...\033[m\n'

source .bashrc
rvm package install zlib ; rvm package install iconv ; rvm package install openssl ; rvm package install readline

echo -e '\033[32m == AMBIENTES RUBY E RVM INSTALADOS! ==\033[m\n'
