module Concerns::Findable
  def find_by_name(name)
    self.all.find {|i| i.name == name}
  end
end
