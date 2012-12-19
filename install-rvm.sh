!#/usr/bin/env bash
#
# Script name   : install-rvm.sh
#
# Descrição     : Instala o Ruby Version Manager (rvm) e aplica algumas configurações no shell.
#
# Autor         :
#
# Versão        : 0.1
#
# Dependências  : curl
#
# Data          : Dezembro/2012
#---------------------------------------------
echo '=== Baixando e instalando o Ruby Version Manager (rvm) ==='
sleep 4

cd $HOME

curl -L https://get.rvm.io | bash -s stable || exit 1

echo '=== Executando configurações pós instalação ==='

echo 'source "$HOME/.rvm/contrib/ps1_functions"' >> $HOME/.bashrc
echo 'ps1_set' >> $HOME/.bashrc
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> $HOME/.bashrc

source $HOME/.bashrc
echo 'install: --no-rdoc --no-ri' >> $HOME/.gemrc
echo 'update: --no-rdoc --no-ri' >> $HOME/.gemrc

echo 'Configurações concluídas! Faça o teste executando: source $HOME/.bashrc; rvm list known'

# rvm --skip-autoreconf pkg install autoconf
# rvm pkg install readline
# rvm pkg install iconv
# rvm pkg install zlib
# rvm pkg install openssl


