#!/usr/bin/env ruby
#coding: utf-8

dir = ARGV[0]
Kernel.abort "Diretório: #{dir} nao existe" unless File.directory?(dir)


#dir =|| %x{echo $HOME}.chomp
Dir.chdir("#{dir}")
#@i = 1

Dir.glob('*.wma') do |f|
  arq = File.basename(f, '.wma')
  puts "Convertendo #{arq} para wav com mplayer...\n\n"
  %x[mplayer "#{f}" -ao pcm:file="#{arq}".wav]
  puts "Normalizando audio com normalize-audio...\n\n"
  %x[normalize-audio "#{arq}".wav]
  puts "Convertendo para mp3 com lame...\n\n"
  %x[lame --noreplaygain -b 192 "#{arq}".wav "#{arq}".mp3]
end

#Dir.glob('teste.*') do  |f|
#  nome = File.basename(f, '.*')
##  File.rename(f, "#{nome}.t" + @i.to_s)

#  File.rename(f, File.basename(f, '.*') << '.' << @i.to_s)
#  @i += 1
#  end
#  
Kernel.system 'rm *.wma'
Kernel.system 'rm *.wav'
Kernel.system 'ls *.mp3'
