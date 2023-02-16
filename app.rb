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
    @rental_store = DataStore.new('rentals')
    # rubocop:disable all
    def result(para)
      if para['personObj']['type'] == 'Student'
        Student.new(para['personObj']['classroom'], para['persObj']['age'], para['persObj']['name'],
                    parent_permission: para['persObj']['parent_permission'])
      else
        Teacher.new(para['personObj']['specialization'], para['personObj']['age'], para['personObj']['name'],
                    parent_permission: para['personObj']['parent_permission'])
      end
    end
    # rubocop:enable all

    @rentals = @rental_store.read.map do |rentals|
      Rental.new(rentals['data'], Book.new(rentals['bookObj']['title'], rentals['bookObj']['author']), result(rentals))
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

  # List all Books option "1"
  def list_all_books
    puts 'All books'
    if @books.length > 0
      @books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    else
      puts 'No book added'
    end
  end

  # List all people option "2"
  def list_all_people
    if @people.length > 0
      @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    else
      puts 'No person added'
    end
  end

  # create a person option "3"
  def create_a_person
    print 'Want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    case person_type
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'That is not a valid input'
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Class room: '
    classroom = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase
    case parent_permission
    when 'y'
      @people.push(Student.new(classroom, age, name, parent_permission: true))
    when 'n'
      @people.push(Student.new(classroom, age, name, parent_permission: false))
    else
      puts 'Invalid input'
    end
    puts 'Student created successfully!'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    @people << Teacher.new(age, specialization, name, parent_permission: true)
    puts 'Teacher created successfully!'
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

  # create a rental book option "5"
  def create_a_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book_index = gets.chomp
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp
    print 'Date: '
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_index.to_i], @people[person_index.to_i])
    puts 'Rental created successfully'
  end

  # List all rental with id option "6"
  def list_all_rentals
    print 'Enter ID of the person: '
    @id1 = gets.chomp.to_i
    rentals = @rentals.map(&:create_json)
    rentals.each { |rental|
      if @id1 == rental[:id]
        print "Title: #{rental[:bookObj][:title]} Author: #{rental[:bookObj][:author]} \n"
      else
        puts 'No rental with this id!'
      end
    }
  end

  # Exit from the app and write all data in files
  def close
    book = @books.map(&:create_json)
    write_data = JSON.pretty_generate(book)
    File.write('books.json', write_data)
    people = @people.map(&:create_json)
    people_data = JSON.pretty_generate(people)
    File.write('people.json', people_data)
    rental = @rentals.map(&:create_json)
    rental_data = JSON.pretty_generate(rental)
    File.write('rentals.json', rental_data)
  end

  def start_loop
    loop do
      welcome
      list_options
    end
  end
end
