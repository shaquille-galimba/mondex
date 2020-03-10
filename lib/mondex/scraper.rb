require 'open-uri'
class Mondex::Scraper

  def self.scrape_list_page(index_url)
    list_page = Nokogiri::HTML(open(index_url))
    monsters = []

    list_page.css("section.jsx-1653715561.jsx-3569582989.wiki-section tr td a:last-child").each do |monster|
      monster_link = monster.attribute("href")
      monster_name = monster.text
      monsters << {name: monster_name, url: monster_link}
    end
    monsters
  end

  # def self.scrape_monster_page(url)
  #   monster = {}
  #   monster_page = Nokogiri::HTML(open(url))
  #
  #
  # end

end
