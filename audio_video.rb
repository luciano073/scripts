#!/usr/bin/env ruby
# encoding: utf-8


#extrai audio de arquivo de video
avconv -i ja-nao-sei-mais-nada.mp4 -f mp3 -vn -ar 44100 -ac 2 -b:a 192k -c:a libmp3lame ja-nao-sei-mais-nada.mp3
