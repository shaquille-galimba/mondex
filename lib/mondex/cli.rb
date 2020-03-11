class Mondex::CLI
  def call
    puts "Welcome to Mondex!"
    puts "Your monster hunter 'Pokedex'!"
    puts "'Know your enemy' before you hunt and carve your spoils!"
    puts "Pick the number of your choice."
    # Mondex::Scraper.new.try
    # Methods:
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

  def list_monsters(array_of_monster_instances = nil)
    puts "Type the name of the monster to view its details"
  end

  def list_species
    puts "Pick a number to show all monsters that belong to that species"
  end

  def invalid_selection
    puts "Please pick a valid selection"
  end
end
