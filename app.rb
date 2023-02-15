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
    when '2'
      list_all_people
    when '3'
      create_a_person
    when '4'
      create_a_book
    when '5'
      create_a_rental
    when '6'
      list_all_rentals
    when '7'
      puts 'File saved successfully!'
      puts 'Thank you for using this app!'
      close
      exit 0
    end
  end

  # Create & store a Book

  def create_a_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def close
    @book_store.write(@books.map(&:create_json))
  end

  def start_loop
    loop do
      welcome
      list_options
    end
  end
end
