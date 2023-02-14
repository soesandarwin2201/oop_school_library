require './app'
require './display_app'

class RunApp
  def initialize
    @app = App.new
    @display = DisplayApp.new
  end

  def choose(choice)
    case choice
    when '1'
      @app.list_all_books
    when '2'
      @app.list_all_people
    when '3'
      @app.create_a_person
    when '4'
      @app.create_a_book
    when '5'
      @app.create_a_rental
    when '6'
      @app.list_all_rentals
    end
  end

  def run
    puts 'Welcome to the school library'
    loop do
      choice = @display.chose_option
      return if choice == '7'

      choose(choice)
    end
  end
end
