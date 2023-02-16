require './person'

require './student'

require './teacher'

require './classroom'

require './book'

require './rental'

require 'json'



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

    [title, author]

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



  def store_data

    books_json = @books.map { |book| { title: book.title, author: book.author} }.to_json

    people_json = @people.map { |person| { id: person.id, age: person.age, name: person.name, rentals: person.rentals }}.to_json

    rentals_json = @rentals.map{ |rental| 

  {

    date: rental.date,

    book: {

      title: rental.book.title,

      author: rental.book.author,

      rentals: rental.book.rentals

    },

    people: {

      id: rental.person.id,

      name: rental.person.name,

      age: rental.person.age,

      rentals: rental.person.rentals

    }

  }}.to_json

  write_book_data = File.open('books.json', 'w')

  write_people_data = File.open('people.json', 'w')

  write_rental_data = File.open('rentals.json', 'w')

  write_book_data.write(books_json)

  write_people_data.write(people_json)

  write_rental_data.write(rentals_json)

  end



  def create_json_file

    if File.exist?('books.json')

      read_book = File.read('books.json')

      json_book = JSON.parse(read_book)

    else

      File.write('books.json',[])

      json_book = []

    end



    return if json_book.empty?

    create_book = json_book.map{ |book| Book.new(book['title'], book['author'])}

    create_book.map { |book| @book << book }

  end



  def create_people_json

    if File.exist?('people.json')

      people_data = File.read('people.json')

      people_file = JSON.parse(people_data)

    else

      File.write('people.json',[])

      people_file = []

    end



    return if people_file.empty?



    person = people_file.map do |person|

  if person['type'] == 'Student'

     Student.new(person['classroom'], person['age'], person['name'], 

        parent_permission: person['parent_permission'])

  else 

   Teacher.new(person['specialization'], person['age'], person['name'], parent_permission: person['parent_permission'])

  end

   person.map{ |person| @people << person }

  end
end



  def create_rental_json

    if File.exist?('rentals.json')

      rental_data = File.read('rentals.json')

      rental_file = JSON.parse(rental_data)

    else

      File.write('rentals.json', [])

      rental_file = []

      end



      return if rental_file.empty?



      new_rentals = rental_json.map {

        |rental| 

        Rental.new(

          rental['date'],

          Book.new(rental['book']['title'], rental['book']['author']),

          Student.new(rental['person']['classroom']['age'], rental['person']['name'],true)

        )

      }

      new_rentals.map{ |rental| @rentals << rental }

  end



  def create_json

    create_json_file

    create_people_json

    create_rental_json

  end



end

