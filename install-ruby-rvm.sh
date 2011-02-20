#!/bin/bash
#
# install-ruby-rvm.sh
#
# Descricao: Instala pacotes da linguagem ruby (versao >1.8.7) e a ferramenta de linha de comando Ruby Version Manager (rvm)
#
# Autor :
#
# Versao 0.2
#
# Data : Dezembro/2010
#------------------------------------------------------
echo -e '\033[32m\n ---> Instalando ruby, vim e pacotes extras...\033[m\n'

sudo apt-get install build-essential subversion git-core git-svn ssh vim-gtk curl ruby ruby-dev rubygems rake irb zlib1g-dev libssl-dev sqlite3 libsqlite3-dev exuberant-ctags ncurses-term ack bison openssl libreadline5 libreadline6-dev libxml2-dev autoconf sun-java6-bin sun-java6-jre sun-java6-jdk icedtea6-plugin

#[ -e apterror.txt ] || { echo "Pacote(s) nao instalado(s): $(cat apterror.txt)" ; exit 1 ; }

cd "$HOME"
echo -e '\033[32m\n ---> Baixando vimfiles do github (cofigurando o vim)...\033[m\n'

git clone git://github.com/akitaonrails/vimfiles.git .vim

echo "source ~/.vim/vimrc" > ~/.vimrc
cd ~/.vim
git submodule update --init
cd bundle/Command-T/ruby/command-t/
ruby extconf.rb
make
cd ~/.vim
echo -e '\033[32m == EDITOR VIM INSTALADO E CONFIGURADO PARA RUBY! ==\033[m\n'

cd "$HOME"
echo -e '\033[32m ---> Instalando rvm...\033[m\n'


bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

echo "[[ -s \$HOME/.rvm/scripts/rvm ]] && source \$HOME/.rvm/scripts/rvm" >> "$HOME/.bashrc"

echo "export PS1='\w \$(~/.rvm/bin/rvm-prompt i v g) \$(git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /)\n\[\033[37m\]\\$\[\033[00m\] '" >> "$HOME/.bashrc"


echo -e '\033[32m ---> Instalando pacotes rvm...\033[m\n'

source .bashrc
rvm package install zlib ; rvm package install iconv ; rvm package install openssl ; rvm package install readline

echo -e '\033[32m == AMBIENTES RUBY E RVM INSTALADOS! ==\033[m\n\n'

echo -e '\033[32m ---> Configurando git...\033[m\n'

ssh-keygen -t rsa
git config --global user.name "luciano073"
git config --global user.email "luciano073@gmail.com"
git config --global color.status "auto"
git config --global color.branch "auto"
git config --global color.interactive "auto"
git config --global color.diff "auto"

