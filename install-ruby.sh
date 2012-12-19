#!/usr/bin/env bash
#
# Script name   : install-ruby.sh
#
# Descricao     : Instala, via código fonte, a última versão estável do interpretador da linguagem de programação Ruby.
#
# Autor         : Luciano Marques
#
# Versão        : 0.1
#
# Dependências  : wget, sed.
#
# Data          : Dezembro/2012
#------------------------------------------------------

PACKAGES="build-essential zlib1g-dev libssl-dev libreadline-dev git-core curl libyaml-dev libcurl4-dev libsqlite3-dev"

echo -e '\033[32m\n ---> Identificando última versão estável disponível do Ruby...\033[m\n'
TEXTO_BASE=$(wget -q -O - http://www.ruby-lang.org/en/downloads/ | grep '[.]tar[.]gz.*Ruby')
RUBY_URI=$(echo "$TEXTO_BASE" | cut -d \" -f 2)
NET_RUBY_VERSION=$(echo "$TEXTO_BASE" | cut -d '>' -f 3 | tr -d '</a')

echo "=== Identificado: $NET_RUBY_VERSION ==="
sleep 4

echo -e '\033[32m\n ---> Identificando versão Ruby atualmente instalada...\033[m\n'
if [[ -f /usr/bin/ruby -o -f /usr/local/bin/ruby ]]; then
  INST_RUBY_VERSION=$(/usr/bin/ruby -v | cut -d ' ' -f 1,2,5 | tr -d ')' | sed 's/ /-p/2;s/^r/R/')
  if [[ "$NET_RUBY_VERSION" = "$INST_RUBY_VERSION" ]]; then
    echo '=== Ruby disponível igual ao instalado. Saindo sem efetuar instalação! ==='
    exit 0
  fi
  echo "=== Identificado: $INST_RUBY_VERSION"
  sleep 4
else
  echo '=== Nenhuma versão de Ruby instalada! ==='
  sleep 4
fi

pacote_ruby=$(echo "$RUBY_URI" | cut -d '/' -f 7)
# echo '=== Removendo versão instalada, requer privilegios de root...'

# apt-get remove ruby1.8 -y -qq &
# while ps -C apt-get > /dev/null; do
#   echo -n '=> '
#   sleep 4
# done
# echo -e "\nRuby: $INST_RUBY_VERSION removido!"
# exit 0
echo -e "\033[32m\n ---> Baixando $NET_RUBY_VERSION para o diretorio /tmp...\033[m\n"
sleep 2
cd /tmp
wget $RUBY_URI

echo '=== Baixando alguns pacotes necessarios... ==='

echo -e '\033[32m\n ---> Rodando apt-get update...\033[m\n'

apt-get update -y -qq &

echo 'Atualizando lista de pacotes, aguarde...'

while ps -C apt-get > /dev/null; do
  echo -n '=> '
  sleep 2
done
echo -e '\nPacotes atualizados!'
echo -e '\033[32m\n --->Iniciar instalação dos pacotes necessários...\033[m\n'
sleep 4
for i in $PACKAGES ; do
  apt-get install $i -y -qq &
  echo "Instalando o pacote: $i, aguarde..."
  while ps -C apt-get > /dev/null; do
    echo -n '=> '
    sleep 4
  done
  echo -e "\nPacote $i instalado com sucesso!"
  sleep 2
done
# RUBY_URI=$(wget -q -O - http://www.ruby-lang.org/en/downloads/ | grep '[.]tar[.]gz.*Ruby' | cut -d \" -f 2)

echo -e "\033[32m\n ---> Descompactando pacote $pacote_ruby...\033[m\n"
sleep 2
tar zxf $pacote_ruby

cd $(echo $pacote_ruby | cut -d '.' -f 1,2,3)
echo -e '\033[32m\n ---> Instalando "$NET_RUBY_VERSION", esta etapa pode demorar varios minutos...\033[m\n'
sleep 3
./configure
make
make install

echo "=== $NET_RUBY_VERSION instalado com sucesso!"
ruby -v
