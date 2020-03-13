class Mondex::Species
  attr_accessor :name
  attr_reader :monsters

  @@all = []

  def initialize(name)
    @name = name
    @monsters = []
    @@all << self
  end

  # def self.create(name)
  #   self.new(name)
  # end

  def self.all
    @@all
  end

  def self.find_by_name(species_name)
    self.all.find {|s| s.name == species_name}
  end

  def self.create_or_find_by_name(species_name)
    self.find_by_name(species_name) || self.new(species_name)
  end
end
