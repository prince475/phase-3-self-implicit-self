class Dog
  attr_accessor :name, :owner

  def initialize(name)
    @name = name
  end

  def bark
    puts "Woof!"
  end

  def get_adopted(owner_name)
    bark # calls the Dog#bark method and makes self the implicit receiver (self implicitly) without calling self key word on the instance.
    # owner = owner_name will not work since ipmlicit doesn't work on setter methods
    self.owner = owner_name
  end

end
