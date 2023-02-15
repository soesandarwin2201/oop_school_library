require './person'

class Teacher < Person
  def initialize(age, specialization, name = 'unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_s
    "Name: #{@name}, ID: #{@id}, Age: #{@age}, ID : #{@id}"
  end

  def create_json
    { 
      id: @id,
      age: @age,
      specialization: @specialization,
      name: @name,
      parent_permission: @parent_permission
    }
  end
end
