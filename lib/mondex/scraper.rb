require 'open-uri'
class Mondex::Scraper

  def self.scrape_list_page(index_url)
    monster_page = Nokogiri::HTML(open(index_url))
    monsters_list = monster_page.css("#tagged-pages-container a")

    monsters_list.collect do |m|
      monster_name = m.text
      monster_url = m.attribute("href")
      {name: monster_name, url: monster_url}
    end
  end

  def self.scrape_monster_page(url)
    monster = {}

    monster_page = Nokogiri::HTML(open("https:" + url))

    monster[:bio] = monster_page.css("#wiki-content-block blockquote p").text

    monster_box = monster_page.css("div.infobox .wiki_table tr").children.map {|el| el.text.strip}.reject {|c| c.empty?}
    monster_box.each_with_index do |title, idx|
      if title == "Location(s)" || title == "Locations"
        monster[:locations] = monster_box[idx+1]
      elsif title == "Species"
        monster[:species] = monster_box[idx+1].delete_suffix("s")
      elsif title == "Elements"
        monster[:elements] = monster_box[idx+1]
      elsif title == "Weakness" || title == "Weaknesses"
        monster[:weakness] = monster_box[idx+1].gsub(/[(][A-Z]/, "(w").gsub("\u00e2\u00AD\u0090", "*").gsub("\u00A0", "").split /(?=[A-Z])/
      elsif title == "Resistances"
        monster[:resistances] = monster_box[idx+1].gsub(/[(][A-Z]/, "(w").gsub("\u00e2\u00AD\u0090", "*").gsub("\u00A0", "").split /(?=[A-Z])/
      end
    end

    monster[:species] = monster_page.css("#wiki-content-block ul li").find {|t| t.text.include?("Species")}.text.split(": ")[1].delete_suffix("s") unless monster[:species]

    monster
  end

end
