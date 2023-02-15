class Rental
  attr_accessor :date, :person, :book

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book
    # @book.rentals << self
    # @person.rentals << self
  end

  def to_s
    "Date: #{@date}, Person #{@book['title']} , Renter: #{@person['name']}"
  end

  def create_json
   { 
    id: @id,
    date: @date,
    person: @person,
    book: @book
  }
  end

end
