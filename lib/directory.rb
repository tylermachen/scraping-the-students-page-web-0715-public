class StudentDirectory
  attr_reader :students

  def initialize(students)
    @students = students
  end

  def run
    welcome
    help
    get_user_input
    while true
      get_user_input
    end
  end

  def welcome
    puts "\n"
    puts "Welcome to the..."
    puts "✶~----------------------------------------------~✶"
    puts "│ Flatiron School FooTang - 0715 Class Directory │"
    puts "✶~----------------------------------------------~✶"
  end

  def prompt
    puts "\n"
    puts "Please enter a command:"
    print"> "
  end

  def get_user_input
    prompt
    input = gets.chomp.downcase
    case input
      when 'list' then list
      when 'help' then help
      when 'home' then run
      when '1'..Student.count.to_s then profile(input)
      when 'exit' then goodbye
      else invalid_command
    end
  end

  def help
    puts "\n"
    puts "The directory accepts the following commands:"
    puts "---------------------------------------------"
    puts "» help : displays this help message"
    puts "» list : displays a list of all students (and profiles)"
    puts "» home : returns to the welcome screen"
    puts "» exit : exits the program"
  end

  def list
    puts "\n"
    puts "✶~--------------------~✶"
    puts "      Students (#{Student.count})      "
    puts "✶~--------------------~✶"
    puts "\n"
    puts Student.count > 0 ? "Enter a student number below to view their profile!" : "The directory is empty."
    puts "\n"
    @students.keys.each.with_index(1) do |student, index|
      puts index > 9 ? "(#{index}) #{student}" : "(#{index})  #{student}"
    end
  end

  def profile(student_index)
    puts "\n"
    @students.keys.each.with_index(1) do |student, index|
      if student_index.to_i == index
        puts "✶~----------------------------------~✶"
        puts "       #{@students[student].name}'s Profile"
        puts "✶~----------------------------------~✶"
        puts "\n"
        puts "Name: #{@students[student].name}\n\n"
        puts "Tagline: #{@students[student].tagline}\n\n"
        puts "Work Experience: #{@students[student].work}\n\n"
        puts "Education: #{@students[student].education}\n\n"
        puts "Biography:"
        puts "----------"
        puts "#{@students[student].bio}"
        puts "----------"
        puts "web0715.students.flatironschool.com/#{@students[student].profile_url}"
      else
        next
      end
    end
  end

  def goodbye
    puts "\n"
    puts "Goodbye."
    puts "\n"
    abort
  end

  def invalid_command
    puts "\n"
    puts "Invalid input, please try again or type 'help' for a list of commands."
  end
end
