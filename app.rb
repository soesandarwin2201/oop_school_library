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
   @people_store = DataStore.new('people')
    @people = @people_store.read.map do |person|
      if person['type'] == 'Student'
        Student.new(person['classroom'], person['age'], person['name'], parent_permission: person['parent_permission'])
      else
        Teacher.new(person['specialization'], person['age'], person['name'],
                    parent_permission: person['parent_permission'])
      end
    end
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

  # List all people option "2"
  def list_all_people
    puts "No one, You can be the first peron" if @people.empty?
    puts "#{@people.length} is added!"
    @people.each_with_index { |person,index| puts " #{person.class}, #{index + 1 }, ID: #{person.id}, Name: #{person.name}, Age: #{person.age} "}
  end

  #get the input from user
  def ask_name_age
    puts "Age:"
    age = gets.chomp
    puts "Name: "
    name = gets.chomp
    [age,name]
  end

  # create a student
  def create_student
  input = ask_name_age
  puts "Has parent permission?[Y/N]:" 
  answer = gets.chomp.downcase
  case answer
  when 'Y'
    parent_permission = true
  when 'N'
    parent_permission = false
  end
  classroom = Classroom.new('Russian')
  student = Student.new(input[0], classroom, input[1], parent_permission: parent_permission)
  @people << student
  puts "Created student successfully!"
  end

  # create a teacher
  def create_teacher
  input = ask_name_age
  puts "Specialization: "
  specialization = gets.chomp
  teacher = Teacher.new(input[0], specialization, input[1])
  @people << teacher
  end

  # create a person
  def create_a_person
    puts "Do you want to create a student account (1) or teacher account (2)?:"
    choice = gets.chomp
    case choice
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts "Invalid input!"
      return
    end
    puts "Your Account created successfully."
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
    people = @people.map(&:create_json)
    people_data = JSON.pretty_generate(people)
    File.write('people.json', people_data)
  end

  def start_loop
    loop do
      welcome
      list_options
    end
  end
end
