#encoding: utf-8
#!/usr/bin/env ruby -w

require "rubygems" if RUBY_VERSION != "1.9.2"




if RUBY_PLATFORM =~ /(linux)/
    pdf_folder = File.join(ENV['HOME'], "windows", "HQ" + "/")
    linux = true
else
    pdf_folder = File.join("D:", "share", "HQ")
end

require "prawn"
require "prawn/core"
require "prawn/security"
require "enumerator"



azul = "\033[34;1m"
sem_cor = "\033[m"

senha = {
    :user_password => "quadrinhos",
    :owner_password => "quadrinhos",
    :permissons => { :print_document => false }
}

def print_line(n = 1)
    n.times {puts "=" * 40}
end


if ARGV.length < 2
    puts "Informe um diretorio e o nome para o arquivo pdf.\n"
    puts "\nVeja a lista com os possíveis diretórios..."
    print_line
    Dir.chdir(pdf_folder) do
        diretorios = Dir["*"]
        puts diretorios.sort.join(", ")
    end
    exit(1)
end

if linux
    hq_folder = File.join(ENV['HOME'], "windows", "HQ", ARGV[0] + "/")    
else
    hq_folder = File.join(pdf_folder, ARGV[0] + "\\"
end


hq_name = ARGV[1].gsub(/\s/, "-").downcase + ".pdf"
puts hq_name
puts "\nVoce esta executando o script ruby #{azul}\"#{$0}\" #{sem_cor}."
print_line

# print "Informe seu nome: "
# nome = STDIN.gets.chomp!
# puts nome
# exit(1)

# Os metadados nao suportam caracteres acentuados.
# metadata = {
#     :Title => ARGV[0],
#     :Author => "Desconhecido",
#     :CreationDate => Time.now,
#     :Subject => "Quadrinhos Eroticos",
#     :Creator => "Luciano Marques"
# }

# Prawn::Document.generate('teste.pdf', :info => metadata, :page_size => "A4") do
#     text "Meu nome é Luciano"
#     encrypt_document senha
# end
# exit(1)



Prawn::Document.generate(pdf_folder + hq_name, :margin => 0, :page_size => "A4") do
    Dir.chdir(hq_folder) do
        arqs = Dir["*"]
    # puts
        arqs.sort! do |a, b|
            a =~ /\A(\d+)/
            x = $1.to_i
            b =~ /\A(\d+)/
            y = $1.to_i
            x <=> y
        end

        arqs.each do |page|
            image page, :position => :center, :vposition => :center,
            :fit => [594,840]
            print "."
        end

    end
    encrypt_document senha
end

puts "\nFIM"

