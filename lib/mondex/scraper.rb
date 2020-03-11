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
    monster = {}
    monster_page = Nokogiri::HTML(open("https:" + url))

    monster_species = monster_page.css("#wiki-content-block ul li").find {|t| t.text.include?("Species")}
    monster[:bio] = monster_page.css("#wiki-content-block blockquote p").text
    monster[:species] = monster_species.css("a").text unless monster_species.css("a").text == ""

    monster_box = monster_page.css("#infobox .wiki_table tr").children.map {|el| el.text.strip}.reject {|c| c.empty?}
    monster_box.each_with_index do |title, idx|
      if title == "Location(s)" || title == "Locations"
        monster[:location] = monster_box[idx+1]
      elsif title == "Elements"
        monster[:elements] = monster_box[idx+1]
      elsif title == "Weakness"
        monster[:weakness] = monster_box[idx+1].gsub(/[(][A-Z]/, "(w").gsub("\u00e2\u00AD\u0090", "*").gsub("\u00A0", "").split /(?=[A-Z])/
      elsif title == "Resistances"
        monster[:resistances] = monster_box[idx+1].gsub(/[(][A-Z]/, "(w").gsub("\u00e2\u00AD\u0090", "*").gsub("\u00A0", "").split /(?=[A-Z])/
      end
    end
    monster
  end

end
