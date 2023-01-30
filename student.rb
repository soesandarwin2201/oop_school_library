require './person'

class Student < Person
  def initialize(age, name = 'unknown', parent_permission = true, classroom)
    super(age, name, parent_permission)

    @classroom = classroom
  end

  def play_hocky
    '¯(ツ)/¯'
  end
end
