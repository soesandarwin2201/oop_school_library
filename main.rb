require_relative 'app'

puts "Welcome to school library"

# class Library
#  def initialize
#   @app = App.new
#  end

#  def choice
#  case chose_option
#  when '1'
#   @app.list_all_books
#  when '2'
#   @app.list_all_people
#   when '3'
#    @app.create_a_person
#   when '4'
#    @app.create_a_book
#   when '5'
#    @app.create_a_rental
#   when '6'
#    @app.list_all_rentals
#   when '7'
#    exit!
#    choice
#   end
#  end

#  def run
#   choice
#  end

# end

# def main
#  app = Library.new()
#  app.run
# end

def main
 app = App.new()
 app.run
end

main()


