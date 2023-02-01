class Book
  attr_accessor :title
  attr_accessor :author
  attr_reader :rentals

 def initialize(title,author)
  @title = title
  @author = author
  @rentals = []
 end
  
 def add_rental(rental)
  @rentals << rental
 end
end
