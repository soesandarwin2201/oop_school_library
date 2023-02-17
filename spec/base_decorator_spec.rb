require './base_decorator'
require './person'
require './capitalize_decorator'
require './trimmer_decorator'


describe CapitalizeDecorator do
  context 'test for the CapitalizeDecorator class' do
    it 'should test the correact capital name ' do
      person = Person.new(20, 'soe')
      capital = CapitalizeDecorator.new(person)
      expect(capital.correct_name).to eq 'Soe'
    end
  end

  it 'should test for correact name length' do
    person = Person.new(20, 'mother of dragon')
    trimmer = TrimmerDecorator.new(person)
    expect(trimmer.correct_name).to eq 'mother of '
  end
end
