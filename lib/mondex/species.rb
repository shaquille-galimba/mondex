class Mondex::Species
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :monsters

  @@all = []

  def initialize(name)
    @name = name
    @monsters = []
    @@all << self
  end

  def self.all
    @@all.sort_by {|s| s.name}
  end

  def self.create_or_find_by_name(species_name)
    self.find_by_name(species_name) || self.new(species_name)
  end
end
