require './teacher'

describe Teacher do
  context 'Create the test for the teacher class' do
    it 'Test the attribut of the teacher class' do
      age = 20
      specialization = 'English'

      teacher = Teacher.new(specialization, age)
      can_use_service = teacher.can_use_services?
      expect(teacher.name).to eq 'Unknown'
      expect(teacher.age).to eq 20
      expect(teacher.id).to be_between(1, 1000)
      expect(can_use_service).to be_truthy
    end
  end
end
