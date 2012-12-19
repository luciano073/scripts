!#/usr/bin/env bash
#
# Script name   : install-vim.sh
#
# Descrição     : Instala o editor de texto Vim e alguns plugins
#
# Autor         : Luciano Marques
#
# Versão        : 0.1
#
# Dependências  : sudo
#
# Data          : Dezembro/2012
#---------------------------------------------
echo -e '\033[32m\n --->Instalando vim e demais pacotes necessarios...\033[m\n'
sleep 4
# substituir vim por vim-gtk para instalar o vim modo grafico.
sudo apt-get install exuberant-ctags ncurses-term vim ack-grep

echo -e '\033[32m\n --->Executando configuracoes pos instalacao: arquivos vimrc e instalacao de plugins...\033[m\n'
sleep 4
# cofiguracoes pos-instalacao

cd $HOME
mkdir -p $HOME/.vim/autoload
mkdir -p $HOME/.vim/bundle
# instala plugins
echo -e '\033[32m\n --->Instalando o plugin [pathogen]...\033[m\n'
sleep 4
curl -Sso $HOME/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
echo 'call pathogen#infect()' >> $HOME/.vim/vimrc
echo 'syntax on' >> $HOME/.vim/vimrc
echo 'filetype plugin indent on' >> $HOME/.vim/vimrc 
echo 'source ~/.vim/vimrc' >> ~/.vimrc
echo 'Helptags' >> ~/.vimrc

cd ~/.vim/bundle
echo -e '\033[32m\n --->Instalando plugin [vim-surround]...\033[m\n'
sleep 4
git clone git://github.com/tpope/vim-surround.git
echo -e '\033[32m\n --->Instalando plugin [vim-commentary]...\033[m\n'
sleep 4
git clone git://github.com/tpope/vim-commentary.git

# instala plugin snipmate e dependencias
echo -e '\033[32m\n --->Instalando plugin [snipmate + dependencias]...\033[m\n'
sleep 4
git clone git://github.com/garbas/vim-snipmate.git
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/honza/snipmate-snippets.git

echo -e '\033[32m\n --->Instalando plugin [delimitMate]...\033[m\n'
sleep 4
git clone https://github.com/Raimondi/delimitMate.git

echo -e '\033[32m\n --->Instalando plugin [supertab]...\033[m\n'
sleep 4
git clone https://github.com/ervandew/supertab.git

echo -e '\033[32m\n --->Instalando plugin [vim-ruby]...\033[m\n'
sleep 4
git clone git://github.com/vim-ruby/vim-ruby.git

echo -e '\033[32m\n --->Instalando plugin [ctrlp]...\033[m\n'
sleep 4
git clone https://github.com/kien/ctrlp.vim.git

echo -e '\033[32m\n --->Instalando plugin [nerdtree]...\033[m\n'
sleep 4
git clone https://github.com/scrooloose/nerdtree.git

echo -e '\033[32m\n --->Instalando plugin [ack]...\033[m\n'
sleep 4
git clone https://github.com/mileszs/ack.vim.git

echo -e '\n=== Instalacao encerrada com sucesso! ==='
