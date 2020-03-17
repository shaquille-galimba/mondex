1. flow
2. classes
  2a. class relationships

FLOW
  Application greets the user and give a brief description about itself
  Ask user if they want to list all the monster, list species, or exit the application
    if user choose to list all the monster
      list all the monster
      ask user to choose monster of their choice or view all monster
      prints out the details of the chosen monster
    if user choose to list species
      list all the species
      ask user to choose a specific species
      list all the monsters that belongs to the species
      ask user to choose from the monster list or view all
      prints out the details of the chosen monster
    if user choose exit
      exit the program

CLASSES
  -CLI
  -Scraper
  -Monster
  -Species

CLASS RELATIONSHIPS
  -Monster has one Species
  -Species has many Monster
  -Scraper scrape data to create Monster instances and give its attributes
  -CLI interact and give information with the user





https://monsterhunterworld.wiki.fextralife.com/Large+Monsters
	-Boss
		-Species, Locations
		-Link to a specific boss
		-Name
		-Description
		-Weakness
	-Species
		-Monster
		-Name
