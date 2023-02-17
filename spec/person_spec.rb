require './person'

describe Person do
 
 context "Test for the person class"
 it "test the methods for the person class " do
  age = 21 
  person = Person.new(age)
  can_use_service = person.can_use_services?
  expect(person.age).to be  21
  expect(person.age).to be > 18
  expect(person.name).to eq 'Unknown'
  expect(person.id).to be_between(1,1000)
  expect(can_use_service).to be_truthy
 end

 it "test the all methods of person class" do
 name = "soe sandar win"
 age = 20
 soe = Person.new(age,name)
 can_use_service = soe.can_use_services?
 of_age = soe.of_age?

 expect(soe.age).to be > 18
 expect(soe.name).to eq 'soe sandar win'
 expect(can_use_service).to be_truthy
 expect(of_age).to be_truthy
end
end