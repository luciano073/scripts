#coding: utf-8
#!/usr/bin/env ruby -w

require "rubygems"
require "mechanize"
require "nokogiri"
require "open-uri"
require "fileutils"

agent = Mechanize.new
agent.user_agent = 'Linux Firefox'
url = manga_root = "http://quadrinhoseroticos.net/"
agent.get(manga_root)
hq_folder = File.join(ENV['HOME'], "windows", "HQ")

np_url = agent.page.link_with(:text  => /[UÚ]ltima/u).href
mt = np_url.match(/(\d+)$/)
num_paginas = mt[1].to_i



#mt2 = url.match(/(.+[\D])/)
#puts mt2[1]
#i = 1
#url = manga_root << "page/#{num_paginas - i}".to_s
#puts url
#exit 0
qtd_files = 0
qtd_hq = 0

if ARGV.length > 0
    agent.get(manga_root + "page/" + ARGV[0])
    url = manga_root + "page/" + ARGV[0]
end
# puts url
# puts agent.page.uri
# exit(1)

# Obtendo links dos quadrinhos na pagina
lk = agent.page.links_with(:text  => 'Read More')
lk.each do |l_page|
    pg = agent.click(l_page)
    qtd_hq += 1
    arq_num = 1
    
    #Definindo o nome da pasta para salvar as imagens
    d_folder = Nokogiri::HTML(open(l_page.href))
    str = d_folder.at_css('.article-title').text
    mt = str.match(/\A(\w+\s?\w+?\s)(.+)/i)
    puts "====================================================\n"
    puts "Baixando a #{qtd_hq}a. HQ: [#{mt[2]}] - URL: #{url}"
    puts "====================================================\n"
    folder = mt[2].gsub(/\W/, "").downcase
    
    unless File.directory?(hq_folder + "/" + folder)
        FileUtils.cd(FileUtils.makedirs(hq_folder + "/" + folder)[0])
        
    #Definindo os links contendo as imagens e baixando-as
        img_links = pg.links.select do |img_lk|
        img_lk.href =~ /.+\d+.+jpg$/      
    end

    img_links.each do |l_img|
        img_file = agent.click(l_img)
      
        puts "Salvando a imagem: #{img_file.filename} na pasta: [#{Dir.getwd}]"
      
        img_file.save(arq_num.to_s + "-" + img_file.filename)
        qtd_files += 1
        arq_num += 1
    end
    
    FileUtils.cd(hq_folder)
    File.open("log.txt", "a") do |log|
    log.puts("[#{Time.now.strftime("%d/%m/%Y  %H:%M")}] Baixando a #{qtd_hq}a. HQ: [#{mt[2]}] - URL: #{url}")
    end
  end
  
end 

puts "Baixados [#{qtd_files}] arquivos."

FileUtils.cd(hq_folder)
File.open("log.txt", "a") do |log|
  log.puts("Baixados [#{qtd_files}] arquivos.")
  log.puts("=" * 80)
end
    
#while i < num_paginas
#  agent.get :url  => url, :referer  => agent.page
#  lk = agent.page.links_with(:text  => 'Read More')
#  lk.each do |lpage|
#    pg = agent.click(lpage)
#    
#    #Definindo o nome da pasta para salvar as imagens
#    d_folder = Nokogiri::HTML(open(lpage.href))
#    str = d_folder.at_css('.article-title').text
#    mt = str.match(/\A(quadrinhos? eroticos? )(.+)/i)
#    #puts mt[1]
#    folder = mt[2].gsub(/\W/, "")
#    
#    FileUtils.cd(FileUtils.makedirs(hq_folder + "/" + folder)[0])
#    
#    #Definindo os links contendo as imagens e baixando-as
#    img_links = pg.links.select do |img_lk|
#      img_lk.href =~ /.+\d+.+jpg$/      
#      end
#      img_links.each do |l_img|
#        img_file = agent.click(l_img)
#        puts "Salvando a imagem: #{img_file.filename} na pasta: #{Dir.getwd}" 
#        img_file.save(img_file.filename)
#        qtd_files += 1
#                
#        end
#    end
#    
#    i += 1
#    if i == 21
#      url = manga_root
#    else
#      url = manga_root << "page/#{num_paginas - i}".to_s
#    end
#    puts "Baixados [#{qtd_files}] arquivos."
#end

#t = agent.page.links_with(:text  => 'Read More')
#t.each do |l|
#  p = agent.click(l)
#  puts p.uri.to_s
#  chapter_links = p.links.select do |lc|
#    lc.href =~ /.+\d+.+jpg$/
#    end
#  puts chapter_links[0].to_s  
#  end

#puts p.uri.to_s
#page = agent.get('http://quadrinhoseroticos.net/quadrinhos-eroticos/quadrinho-erotico-levando-mandioca.html')
#doc = Nokogiri::HTML(open('http://quadrinhoseroticos.net/quadrinhos-eroticos/quadrinho-erotico-levando-mandioca.html'))
#doc.css('.wp-image-328').each do |item|
#  puts item[:href].to_s
#  end
#doc = Nokogiri::HTML(open('http://quadrinhoseroticos.net/quadrinhos-eroticos/quadrinhos-eroticos-priminha-gostosa-2.html'))
##puts doc.at_css('.last')[:href]
#str = doc.at_css('.article-title').text
#mt = str.match(/\A(quadrinhos? eroticos? )(.+)/i)
#puts mt[1]
#puts mt[2].gsub(/\W/, "")
#doc.css('.wp-pagenavi').each do |item|
#  puts item.at_css('.previouspostslink')[:href]
#  end

#chapter_link = agent.page.links.select do |l|
#  l.href =~ /.+\d.+jpg$/
##  puts l.href.to_s
#  end
#  
#chapter_link.each do |l|
#  arq = agent.click(l)
#  arq.save(arq.filename)
#  puts arq.filename
#  end

#p = page.link_with(:text  => /.ltima.+/i).click
#agent.get(page.link_with(:text  => 'Read More').click)



