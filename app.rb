require "./person"
require "./student"
require "./teacher"
require "./classroom"
require "./book"
require "./rental"
require "./main.rb"

class App
  def initialize
   @books = []
   @people = []
   @rentals = []
  end

  # list all the books
  def list_all_books
   puts "No book is available right now!" if @books.length == 0
   puts "There are #{@books.length} books is available"
   @books.each_with_index {
    |book,index| puts "#{index + 1}, Title : #{book.title} , Author : #{book.author}"
   }
  end

  # list all the people 
  def list_all_people
   puts "No one!You can be the first person" if @people.length == 0
   puts "#{@people.length} added!"
   @people.each_with_index { |person,index| puts "#{index + 1 }, Name: #{person.name} , Age: #{person.age} " }
  end

  # create a student

  def create_student
   puts "Age: "
   age = gets.chomp
   puts "Name: "
   name = gets.chomp
   puts "Has parent permission?[Y/N]"
   answer = gets.chomp.downcase
   case answer
   when "Y"
    parent_permission = true
   when "N"
    parent_permission = false
   end
   classroom = Classroom.new("Russian")
   student = Student.new(age,classroom,name,parent_permission)
   @people << student
   puts " created!"
  end

  def create_teacher
   puts "Age:"
   age = gets.chomp
   puts "Name: "
   name = gets.chomp
   puts " Specialization: "
   specialization = gets.chomp
   teacher = Teacher.new(age,specialization,name)
   @people << teacher
   puts "teacher created"
  end

  def create_a_person
   puts "Do you want to create a student account(1) or teacher account (2)"
   choice = gets.chomp
   case choice
   when '1'
    create_student
   when '2'
    create_teacher
   else
    puts "invalid input"
    return 
   end
   puts "created!"
  end

  # creat book
  def create_a_book
   puts "Title : "
   title = gets.chomp
   puts "Author: "
   author = gets.chomp
   book = Book.new(title,author)
   @books << book
   puts "Book created"
  end

  # create a rental
  def create_a_rental
    puts "Select a book from the following list by number: "
  @books.each_with_index {
    |book,index| puts "#{index + 1}, Title : #{book.title} , Author : #{book.author}" }
   puts @books

   chosen_book = gets.chomp.to_i

   puts "Select a person from the following list by number (not id)"
    @people.each_with_index { |person,index| puts "#{index + 1 }, Name: #{person.name} , Age: #{person.age} " }
   chosen_person = gets.chomp.to_i

   puts "Date: [yyyy,mm,dd]"
   date = gets.chomp.to_s
   rental = Rental.new(date, @people[chosen_person], @books[chosen_book])

   @rentals << rental
   puts "rental created"
  end

  def list_all_rentals
    puts "no rentals available" if @rentals.length == 0
    puts "input your id to see the rental: "
    rental = gets.chomp.to_i

    puts "Rental list:"
    @rentals.each_with_index { |rental,index| puts "#{index}, Date : #{rental.date}, Name: #{rental.name}, BookName: #{rental.title}, Author: #{rental.author}" }
  end

  def chose_option
    puts "Please an option by selecting a number:
    1. List all books
    2. List all people
    3. Create a person
    4. Create a book
    5. Create a rental
    6. List all rentals for a givem person id
    7. Exist"
    answer = gets.chomp
  end

end