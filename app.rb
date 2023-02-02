require "./book.rb"
require "./person.rb"
require "./student.rb"
require "./teacher.rb"
require "./rental.rb"

class App

 def initialize
  @books = []
  @people = []
  @rentals = []

 end

 # list all the book
 def list_all_books
  puts "There are #{books.length} in this book list"
  @books.each { |book| puts "Title : #{title} , Author : #{author}" }
 end

 # list all people

 def list_all_people
  puts "#{people.length} is added to the list!"
  @people.each { |person| puts "Id : #{person.id}, Name : #{person.name}, Age : #{person.age}"}
 end

 # create a person
 def create_a_person
  puts "Do you want to create a student(1) or a teacher (2)?"
  answer = gets.chomp
  case answer 
  when "1"
    create_student(name,age,parent_permission)
  when "2"
    create_teacher(age,name,specialization)
  else
    print "Please try again"
  end

 end

 # create a student
 def create_student
  puts "Age:"
  age = gets.chomp
  puts "Name: "
  name = gets.chomp
  puts "Do you have your parent permission? [Y/N]"
  answer = gets.chomp.downcase
  case answer
  when 'y'
    parent_permission = true
  when 'n'
    parent_permission = false
  else
    puts "Invalid,failed"
  end
  student = Student.new(age, name, parent_permission)
  @people << student
  print "Student created"
  end

  # create a teacher 

  def create_teacher
    puts "Age:"
    age = gets.chomp
    puts "Name:"
    name = gets.chomp
    puts "What is your specialization?"
    specialization = gets.chomp
    teacher = Teacher.new(age: age, name: name, specialization: specialization)
    @people << teacher
    print "teacher created"
  end

  # create a book
   def create_book
    puts "Title:"
    title = gets.chomp
    puts "Author: "
    author = gets.chomp
    book = Book.new(title,author)
    @books << book
    print "Book created"
   end

   # create a rental

   def creat_rental
    puts "select a book from the following lists by number"
    @books.each_with_index{ |book,index| puts "#{book.index + 1 } : Title : #{book.title} , Author : #{book.author}" }
    book_index = gets.chomp.to_i
    chosen_book = @books[book_index]
    
    puts "Select a person from the following list by number(not id)"
    @people.each_with_index { |person,index| puts "#{person.index}, Name: #{person.name} ,Id : #{person.age}" }
    person_index = gets.chomp.to_i
    chosen_person = @people[person_index]

    puts "Enter your date[yyyy-mm-dd]:"
    date = gets.chomp.to_s

    rental = Rental.new(date: date,person: chosen_person, book: chosen_book)
    @rentals << rental
    print "Book created!"
   end

   # create a list for rental

   def list_rentals
    puts "Id of person:"
    id = gets.chomp.to_i

    puts "Rentals: "
    rental = @rentals.select { |rent| rent.person.id == id }
    if rental.length == 0
      puts "You don't have a rental book"
    else
      puts "Here is your books"
      rental.each_with_index { |rental, index| puts "#{index} #{rental}"}
    end
  end
  




end