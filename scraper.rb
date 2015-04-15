# This is a template for a Ruby scraper on Morph (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
#
agent = Mechanize.new
#
# # Read in a page
page = agent.get(" http://www.congreso.es/portal/page/portal/Congreso/Congreso/Diputados?_piref73_1333056_73_1333049_1333049.next_page=/wc/menuAbecedarioInicio&tipoBusqueda=completo&idLegislatura=10")
#todos los enlaces de una pagina
#page.links.each do |link|
  #puts link.text
#end
#todos los diputados 
diputados = []
while true
 diputados.concat(page.links_with(href: /fichaDiputado/))
  page.links_with(href: /fichaDiputado/).each do |link|
   # puts link.text
  end
  next_page=page.link_with(text: /Siguiente/)
  break if next_page ==nil
  page= next_page.click
end
#page = agent.get("http://www.congreso.es/portal/page/portal/Congreso/Congreso/Diputados/BusqForm?_piref73_1333155_73_1333154_1333154.next_page=/wc/fichaDiputado?idDiputado=268&idLegislatura=10")

diputados.each do |diputado
  page =diputado.click
name = page.search('div.nombre_dip').text
#mail = page.links_with(href: /mailto/)
div =  page.search('div#curriculum')
div.search('a').each do |link|
  #puts link['href'] if link['herf'] =~/mailto:/
end
#email= div.search('a[href*=mailto').text.strip
email_link= div.search('a[href*=mailto]')
email=email_link ? email_link.text.strip : ''

puts "'#{name}', #{email}""
#div.search('a[href*=mailto').text.strip
end


#.nombre
# # Find somehing on the page using css selectors
# p page.at('div.content')
#
# # Write out to the sqlite database using scraperwiki library
#ScraperWiki.save_sqlite(["name"], {"name" => "juan", "occupation" => "CDO ABC.es"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries. You can use whatever gems are installed
# on Morph for Ruby (https://github.com/openaustralia/morph-docker-ruby/blob/master/Gemfile) and all that matters
# is that your final data is written to an Sqlite database called data.sqlite in the current working directory which
# has at least a table called data.
#puts 'hola mundo'
