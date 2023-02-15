require './nameable'

class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  attr_reader :id
  attr_accessor :name, :age, :rentals

  def can_use_services?
    return true if @age >= 18 || @parent_permission == true
  end

  def correct_name
    @name
  end

  def add_rental(rental)
    @rentals << rental
    rental.person = self
  end

  def to_s
    "Name: #{@name}, ID: #{@id}, Age: #{@age}, ID : #{@id}"
  end

  def create_json
    {
      id: @id,
      age: @age,
      name: @name,
      parent_permission: @parent_permission,
      specialization: @specialization
    }
  end

  private

  def of_age?
    return true if @age >= 18

    false
  end
end
