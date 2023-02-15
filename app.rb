require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './rental'
require './data_store'
require 'json'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []

    @book_store = DataStore.new('books')
    @books = @book_store.read.map { |book| Book.new(book['title'], book['author']) }
  end

  def list_options
    option = gets.chomp.to_s
    case option
    when '1'
      list_all_books
    # when '2'
    #   list_all_people
    # when '3'
    #   create_a_person
    when '4'
      create_a_book
    # when '5'
    #   create_a_rental
    # when '6'
    #   list_all_rentals
    when '7'
      puts 'File saved successfully!'
      puts 'Thank you for using this app!'
      close
      exit 0
    end
  end

  # List all Books option "1"
  def list_all_books
    puts 'All books'
    @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  # Create & store a Book option "4"
  def create_a_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  # Exit from the app and write all data in files
  def close
    book = @books.map(&:create_json)
    write_data = JSON.pretty_generate(book)
    File.write('books.json', write_data)
  end

  def start_loop
    loop do
      welcome
      list_options
    end
  end
end
