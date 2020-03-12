class Mondex::CLI
  WEBSITE = "https://monsterhunterworld.wiki.fextralife.com/Large+Monsters"
  def call
    create_monsters
    add_attributes_to_monsters
    puts "Welcome to Mondex!"
    puts "Your monster hunter 'Pokedex'!"
    puts "'Know your enemy' before you hunt and carve your spoils!"
    puts "Pick the number of your choice."
    # Mondex::Scraper.new.try
    # Methods:
    # binding.pry

    get_user_choice


      # ask user if they want a list of monster, species, or location
    # list_monsters
    # list_species
    # show_monster_details
  end

  def get_user_choice
    puts "1. List all monster"
    puts "2. List all species"
    puts "3. Exit Mondex :("
    choice = gets.strip

    case choice
    when "1"
      list_monsters
    when "2"
      list_species
    when "3"
      exit
    else
      invalid_selection
      get_user_choice
    end
  end

  def list_all_monster_details
    Mondex::Monster.all.each {|m| view_details("#{m.name}")}
  end

  def list_monsters
    Mondex::Monster.all.each_with_index {|m, i| puts "#{i+1}. #{m.name}"}
    puts "Type the name of the monster to view its details or type 'all' to view all monster details"
    input = gets.strip.capitalize

    if input == "all"
      list_all_monster_details
    else
      view_details(input)
    end
  end

  def list_species
    puts "Pick a number to show all monsters that belong to that species"
  end

  def invalid_selection
    puts "Please pick a valid selection"
  end

  def view_details(input)
    if monster = Mondex::Monster.find_by_name(input)
      puts monster.name
      puts "Species: #{monster.species} | Locations: #{monster.locations}"
      puts "Weaknesses:"
      monster.weakness.each {|w| puts " #{w}"} if monster.weakness
      puts "Resistances:"
      monster.resistances.each {|r| puts "  #{r}"} if monster.resistances
      puts "Elements:"
      puts "  #{monster.elements}"
      puts "Description:"
      puts "  #{monster.bio}"
    else
      invalid_selection
    end
  end

  def create_monsters
    monster_array = Mondex::Scraper.scrape_list_page(WEBSITE)
    Mondex::Monster.create_from_list(monster_array)
  end

  def add_attributes_to_monsters
    Mondex::Monster.all.each do |monster|
      attributes = Mondex::Scraper.scrape_monster_page(monster.url)
      monster.add_attributes(attributes)
    end
  end
end
