require 'colorize'

class Mondex::CLI
  WEBSITE = "https://monsterhunterworld.wiki.fextralife.com/Large+Monsters"
  def call
    puts "Loading...".colorize(:red)
    create_monsters
    add_attributes_to_monsters
    puts "LOADING COMPLETED!".colorize(:green)
    puts "Welcome to Mondex!".colorize(:blue)
    puts "Your monster hunter 'Pokedex'!".colorize(:blue)
    puts "'Know your enemy' before you hunt and carve your spoils!".colorize(:blue)
    binding.pry
    get_user_choice
  end

  def get_user_choice
    puts "Pick the number of your choice.".colorize(:yellow)
    puts "1. List all monster"
    puts "2. List all species"
    puts "3. Exit Mondex :("
    choice = gets.strip

    case choice
    when "1"
      pick_monsters(Mondex::Monster.all)
    when "2"
      print_species
    when "3"
      exit
    else
      invalid_selection
      get_user_choice
    end
  end

  def print_monsters_details(array_of_monsters)
    array_of_monsters.each {|m| print_details(m)}
  end

  def pick_monsters(array_of_monsters)
    print_monsters(array_of_monsters)
    puts "Type the number or name of the monster to view its details or type 'all' to view all monster details".colorize(:yellow)
    input = gets.strip.split.map {|w| w.capitalize}.join(" ")
    number_choice = (input.to_i) - 1
    monsters = array_of_monsters.select {|m| m.name.include?(input)}

    if input == "All"
      print_monsters_details(array_of_monsters)
    elsif monsters != []
      print_monsters_details(monsters)
    elsif number_choice.between?(0, array_of_monsters.count - 1)
      print_details(array_of_monsters[number_choice])
    else
      invalid_selection
    end
    get_user_choice
  end

  def print_monsters(array_of_monsters)
    array_of_monsters.each_with_index {|m, i| puts "#{i+1}. #{m.name}"}
  end

  def print_species
    # Mondex::Species.all.each_with_index {|s, idx| puts "#{idx+1}. #{s.name}"}
    print_monsters(Mondex::Species.all)
    pick_monsters_through_species
  end

  def pick_monsters_through_species
    puts "Pick a number to show all monsters that belong to that species".colorize(:yellow)
    input = (gets.strip.to_i) - 1

    if input.between?(0, Mondex::Species.all.count - 1)
      monsters = Mondex::Species.all[input].monsters
      pick_monsters(monsters)
    else
      invalid_selection
      pick_monsters_through_species
    end
  end

  def invalid_selection
    puts "Please pick a valid selection".colorize(:red)
  end

  def print_details(monster)
      puts "----------------------------------------------------------------------------"
      puts monster.name.colorize(:color => :black, :background => :white)
      puts "Description:".colorize(:blue)
      puts "  #{monster.bio}"
      puts "Species: ".colorize(:light_blue) + "#{monster.species.name} | " + "Locations: ".colorize(:light_blue) + "#{monster.locations}"
      puts "Weaknesses:".colorize(:red)
      monster.weakness.each {|w| puts " #{w}"} if monster.weakness
      puts "Resistances:".colorize(:green)
      monster.resistances.each {|r| puts "  #{r}"} if monster.resistances
      puts "Elements:".colorize(:yellow)
      puts "  #{monster.elements}"
      puts "----------------------------------------------------------------------------"
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
