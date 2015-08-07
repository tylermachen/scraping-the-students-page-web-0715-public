require 'nokogiri'
require 'open-uri'
require 'pry'

class Student
  attr_accessor :name, :profile_url, :tagline, :bio, :work, :education
  attr_reader :default
  @@count = 0
  @@default = "unavailable"

  def initialize(name, profile_url, tagline = @@default, bio = @@default, work = @@default, education = @@default)
    @name = name
    @profile_url = profile_url
    @tagline = tagline
    @bio = bio
    @work = work
    @education = education
    @@count += 1
  end

  def self.count
    @@count
  end
end

class StudentDirectory
  attr_accessor :students

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

def create_student_hash
  html = open('http://web0715.students.flatironschool.com/')
  profile_data = Nokogiri::HTML(html)
  students = {}

  profile_data.css("div.big-comment h3 a").each do |student|
    @name = student.text
    @profile_url = student.values.first

    begin # 404 error handling
      student_html = open('http://web0715.students.flatironschool.com/' + @profile_url)
      student_profile_data = Nokogiri::HTML(student_html)

      tagline = student_profile_data.css("div.textwidget h3").text
      work = student_profile_data.css("div.services h4").text
      education = student_profile_data.css("div.services ul li").text
      bio = student_profile_data.css("div.services p").first.text.strip

      students[@name] = Student.new(@name, @profile_url, tagline, bio, work, education)
    rescue OpenURI::HTTPError => e
      if e.message == '404 Not Found'
        students[@name] = Student.new(@name, @profile_url)
        next
      end
    end
  end

  students
end

StudentDirectory.new(create_student_hash).run
