require "./person"
require "./base_decorator"
require "./capitalize_decorator"
require "./trimmer_decorator"

person = Person.new(22, 'maximilianus')
 puts  person.correct_name
  capitalizedPerson = Capitalize_Decorator.new(person)
 puts  capitalizedPerson.correct_name
  capitalizedTrimmedPerson = Trimmer_Decorator.new(capitalizedPerson)
 puts  capitalizedTrimmedPerson.correct_name