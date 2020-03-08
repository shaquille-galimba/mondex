1. flow
2. classes
  2a. class relationships

FLOW
  Application greets the user and give a brief description about itself
  Ask user if they want to list all the monster, list species, or list locations
    if user choose to list all the monster
      list all the monster
      ask user to choose monster of their choice
      prints out the details of the chosen monster
    if user choose to list species or locations
      list all the species/locations
      ask user to choose a specific species/locations
      list all the monsters that has the specific chosen species/location
      ask user to choose from the monster list
      prints out the details of the chosen monster
  Ask user if they want to go back to choose what to list, go back to the previous list, or exit the Application

CLASSES
  -CLI
  -Scraper
  -Monster
  -Species
  -Location

CLASS RELATIONSHIPS
  -Monster has many Location
  -Monster has one Species
  -Location has many Monster
  -Species has many Monster
  -Scraper scrape data to create Monster instances and give its attributes
  -CLI interact and give information with the user





https://www.ign.com/wikis/monster-hunter-world/Monster_List_-_Monster_Hunter:_World_and_Iceborne
	-Boss
		-Species, Locations(classes)
		-Link to a specific boss
		-Name
		-Description
		-Weakness
	-Species
		-Bosses
		-Name
	-Locations
		-Name
		-Bosses

<!-- require 'nokogiri'
require 'open-uri'

site = "https://www.ign.com/wikis/monster-hunter-world/Monster_List_-_Monster_Hunter:_World_and_Iceborne#Large_Monsters"


page = Nokogiri::HTML(open(site))



monsters = page.css("section.jsx-1653715561.jsx-3569582989.wiki-section tr td")

monsters.each do |m|
  puts m.css("a").text
end -->
