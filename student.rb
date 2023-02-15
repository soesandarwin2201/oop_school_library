require './person'
require './classroom'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name = 'unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hocky
    '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def to_s
    "Name: #{@name}, ID: #{@id}, Age: #{@age}, ID : #{@id}"
  end

  def create_json
    {
      id: @id,
      age: @age,
      classroom: @classroom,
      name: @name,
      parent_permission: @parent_permission
    }
  end
end
