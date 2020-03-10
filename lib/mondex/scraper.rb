require 'open-uri'
class Mondex::Scraper

  def self.scrape_list_page(index_url)
    monsters_list = Nokogiri::HTML(open(index_url))
    monsters = monster_list.css("#tagged-pages-container a")

    monster = []
    monsters.each do |m|
      monster_name = m.text
      monster_url = m.attribute("href")
      monster << {name: monster_name, url: monster_url}
    end
    monster
  end

  def self.scrape_monster_page(url)

  end

end
