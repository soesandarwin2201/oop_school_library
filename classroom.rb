class Classroom
  attr_accessor :label

  def initialize(label)
    @label = label
    @students = [] # have many relationship
  end

  def add_student(student)
   @students.push(student)
   student.classroom = self
  end
end
