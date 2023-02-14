require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  # list all the books

  def list_all_books
    puts 'No book is available right now!' if @books.empty?
    puts "There are #{@books.length} books is available"
    @books.each_with_index do |book, index|
      puts "#{index + 1}, Title : #{book.title} , Author : #{book.author} "
    end
  end

  # list all the people

  def list_all_people
    puts 'No one!You can be the first person' if @people.empty?
    puts "#{@people.length} added!"
    @people.each_with_index do |person, index|
      puts " #{person.class} ,#{index + 1}, Name: #{person.name} , Age: #{person.age} Id : #{person.id}"
    end
  end

  def ask_name_age
    puts 'Age: '
    age = gets.chomp
    puts 'Name: '
    name = gets.chomp
    [age, name]
  end

  # create a student

  def create_student
    input = ask_name_age
    puts 'Has parent permission?[Y/N]'
    answer = gets.chomp.downcase
    case answer
    when 'Y'
      answer = true
    when 'N'
      answer = false
    end
    classroom = Classroom.new('Russian')
    student = Student.new(input[0], classroom, input[1], parent_permission: answer)
    @people << student
    puts ' created!'
  end

  def create_teacher
    input = ask_name_age
    puts ' Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(input[0], specialization, input[1])
    @people << teacher
    puts 'teacher created'
  end

  def create_a_person
    puts 'Do you want to create a student account(1) or teacher account (2)'
    choice = gets.chomp
    case choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'invalid input'
      return
    end
    puts 'created!'
  end

  def ask_title_author
    puts 'Title : '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp
    [title,author]
  end

  # creat book

  def create_a_book
    input = ask_title_author
    book = Book.new(input[0], input[1])
    @books << book
    puts 'Book created'
  end

  def rental_book
    puts 'Select a book from the following list by number: '
    @books.each_with_index do |book, index|
      puts "#{index}, Title : #{book.title} , Author : #{book.author}"
    end
    puts @books
    chosen_book = gets.chomp.to_i
    @books[chosen_book]
  end

  def rental_person
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index { |person, index| puts "#{index}, Name: #{person.name} , Age: #{person.age} " }
    chosen_person = gets.chomp.to_i
    @people[chosen_person]
  end

  # create a rental

  def create_a_rental
    book = rental_book
    person = rental_person
    puts 'Date: [yyyy,mm,dd]'
    date = gets.chomp.to_s
    rental = Rental.new(date, person, book)
    @rentals << rental
    puts 'rental created'
  end

  def list_all_rentals
    puts 'no rentals available' if @rentals.empty?
    puts 'input your id to see the rental: '
    id = gets.chomp.to_i
    puts 'Rental list:'
    @rentals.each_with_index do |rental, index|
      puts "#{index}, Date : #{rental.date}, Name: #{rental.person.name},Age: #{rental.person.age},  BookName: #{rental.book.title}, BookAuthor : #{rental.book.author}" if rental.person.id == id
    end
  end
end
