class Mondex::Monster
  extend Concerns::Findable
  attr_accessor :name, :bio, :locations, :url, :weakness, :elements, :resistances
  attr_reader :species

  @@all = []

  def initialize(monster_hash)
    monster_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_list(monsters_array)
    monsters_array.each do |hash|
      Mondex::Monster.new(hash)
    end
  end

  def add_species(species)
    @species = species
  end

  def add_attributes(hash)
    hash.each do |attribute, value|
      if attribute == :species
        new_species = Mondex::Species.create_or_find_by_name(value)
        self.add_species(new_species)
        new_species.add_monster(self)
      else
        self.send("#{attribute}=", value)
      end
    end
    self
  end

end
