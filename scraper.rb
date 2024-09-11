# scraper.rb
require 'nokogiri'
require 'httparty'

# Função principal que faz o scraping dos títulos e links dos artigos
def scrape_articles(url)
  # Faz a requisição para a URL especificada
  response = HTTParty.get(url)

  # Verifica se a resposta foi bem-sucedida
  if response.code == 200
    # Faz o parsing do HTML usando Nokogiri
    parsed_page = Nokogiri::HTML(response.body)

    # Seleciona os artigos com base em um seletor CSS (exemplo para blogs comuns)
    articles = parsed_page.css('article')

    # Itera sobre cada artigo encontrado e extrai o título e o link
    articles.each do |article|
      title = article.css('h2').text.strip # Altere o seletor conforme a estrutura do site
      link = article.css('a').attribute('href')&.value

      # Exibe o título e o link do artigo
      puts "Título: #{title}"
      puts "Link: #{link}"
      puts "-" * 40
    end
  else
    puts "Erro ao acessar a URL: #{response.code}"
  end
end

# URL do site que deseja fazer scraping
url = 'https://exemplo.com/blog' # Substitua pela URL desejada

# Chama a função para fazer scraping dos artigos
scrape_articles(url)
