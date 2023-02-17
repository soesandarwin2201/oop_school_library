require './student'
require './classroom'
require './person'

describe Student do 
 context 'Test for the student class ' do
  it "Test the attribute of the student class" do
    classroom = 'russian'
    age = 20
    name = 'soe sandar win'
   student = Student.new(classroom,age,name)
   expect(student.name).to eq 'soe sandar win'
   expect(student.age).to eq 20
  end
 end
end