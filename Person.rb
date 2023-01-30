class Person
 attr_reader :id
 attr_accessor :name,:age
 def initialize(age,name = "Unknown", parent_permission = true)
  @id = Random.rand(1..1000)
  @name = name
  @age = age
  @parent_permission = parent_permission
 end

 def is_of_age?
  if @age >= 18
   return true
  end
  return false
 end

 def can_use_services?
  return true if @age >= 18 || @parent_permission == true
 end
end

