require "./book.rb"
require "./person.rb"
require "./student.rb"
require "./teacher.rb"

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
   end


end