require './app'

def welcome
  puts 'Welcome to school library app!'

  puts "Please an option by selecting a number:
    1. List all books
    2. List all people
    3. Create a person
    4. Create a book
    5. Create a rental
    6. List all rentals for a givem person id
    7. Exist"
end

def main
  app = App.new
  app.start_loop
end

main
