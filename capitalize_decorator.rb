require "./base_decorator"

class Capitalize_Decorator < Base_Decorator
 
 def correct_name
  @nameable.correct_name.capitalize()
 end
end
