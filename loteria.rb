#coding: utf-8
#!/usr/bin/env ruby -w

require "rubygems"
require "mechanize"
require "nokogiri"
require "open-uri"

agent = Mechanize.new
agent.user_agent = 'Linux Firefox'

agent.get('http://www1.caixa.gov.br/loterias/index.asp')

doc = Nokogiri::HTML(open(agent.page.uri))
loterias_href = []
agent.page.links.select do |l|
    loterias_href << l.href if l.href =~ /(loteria).+(resultado.asp)$/
end

puts loterias_href.sort
# doc.css('#jogos', 'a').each do |item|
#     puts item.text
#     puts item.at_css('img').text
# end

# doc.at_css('#jogos') do |item|
#     item.at_css('.a').text
# end