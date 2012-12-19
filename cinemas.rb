require "nokogiri"
require "open-uri"
require 'brstring'

uri_araguaia = 'http://www.cinemaslumiere.com.br/busca/Goi%C3%A2nia/1/Araguaia+Shopping/2'
uri_bougainville = 'http://www.cinemaslumiere.com.br/busca/Goi%C3%A2nia/1/Shopping++Bougainville/1'
uri_portal_shopping = 'http://www.cinemaslumiere.com.br/busca/Goi%C3%A2nia/1/Portal+Shopping/3'
uri_portal_aparecida = 'http://www.cinemaslumiere.com.br/busca/Aparecida+de+Goi%C3%A2niaGO/8/Portal+Shopping+Sul/7'
uri_cinemark = 'http://www.cinemark.com.br/programacao/goiania/flamboyant/23/893'
uri_cineritz = 'http://www.cineritzgoiania.com.br/cineritz/index.php?option=com_content&view=article&id=47&Itemid=54'
uri_buriti = 'http://www.moviecom.com.br/tabela_imprime.php?id=APG'
uri_banana = 'http://www.cinemaspremiere.com.br/index.php?option=com_content&view=article&id=47&Itemid=54'

puts "Lumiere: Araguaia Shopping"
doc = Nokogiri::HTML(open(uri_araguaia))
doc.css('div.txt').each do |tag|
  print "\t"
  puts tag.css('h1')[0].content
end

puts "\nLumiere: Shopping Bougainville"
doc_boug = Nokogiri::HTML(open(uri_bougainville))
doc_boug.css('div.txt').each do |tag|
  print "\t"
  puts tag.css('h1')[0].content
end

puts "\nLumiere: Portal Shopping"
doc_portal = Nokogiri::HTML(open(uri_portal_shopping))
doc_portal.css('div.txt').each do |tag|
  print "\t"
  puts tag.css('h1')[0].content
end

puts "\nCinemark: Flamboyant"
doc_flambas = Nokogiri::HTML(open(uri_cinemark))
doc_flambas.css('div#date-1-893 > div.filme').each do |tag|
  print "\t"
  puts tag.css('h4')[0].content
end

puts "\nMoviecom: Buriti Shopping"
doc_buriti = Nokogiri::HTML(open(uri_buriti))
doc_buriti.css('table#tabela2').css('a.screenshot').each do |tag|
  print "\t"
  puts tag.content.lstrip
end

puts "\nPremiere: Banana Shopping"
doc_banana = Nokogiri::HTML(open(uri_banana))
doc_banana.css('div.art-article > table').each do |tag|
  print "\t"
  puts tag.css('tr').first.css('strong')[0].content.gsub(/[[:blank:]]$/, '').gsub(/\-$/, '').nome_proprio
end
