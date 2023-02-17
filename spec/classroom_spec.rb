require './classroom'

describe Classroom do
  context 'Test the calssrrom class' do
    it 'should test the attribut of the test' do
      label = 'russian'
      classroom = Classroom.new(label)
      expect(classroom.label).to eq 'russian'
    end
  end
end
