require './base_decorator'
class Trimmer_Decorator < Base_Decorator
  def correct_name
    @nameable.correct_name[1..10] if @nameable.correct_name.length > 10

    @nameable.correct_name
  end
end
