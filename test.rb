require './person'
require './base_decorator'
require './capitalize_decorator'
require './trimmer_decorator'

person_obj = Person.new(22, 'maximilianus')
puts person_obj.correct_name
capitalized_person = CapitalizeDecorator.new(person_obj)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
