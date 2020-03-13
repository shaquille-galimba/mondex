class Mondex::Monster
  attr_accessor :name, :bio, :species, :locations, :url, :weakness, :elements, :resistances

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

  def self.find_by_name(monster_name)
    monster = Mondex::Monster.all.find {|m| m.name.include?(monster_name)}
  end

  def add_attributes(hash)
    hash.each do |attribute, value|
      if attribute == :species
        new_species = Mondex::Species.create_or_find_by_name(value)
        self.send("#{attribute}=", new_species)
        new_species.monster << self
      else
        self.send("#{attribute}=", value)
      end
    end
    self
  end

end
