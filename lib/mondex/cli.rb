class Mondex::CLI
  def call
    puts "Welcome to Mondex!"
    Mondex::Scraper.new.try
    # Methods:
    # get_user_choice
      # ask user if they want a list of monster, species, or location
    # list_monsters
    # list_species
    # list_locations
    # show_monster_details
  end
end
