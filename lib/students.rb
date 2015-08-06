# scraper
require 'nokogiri'
require 'open-uri'
require 'pry'

def create_student_hash
  html = open('http://web0715.students.flatironschool.com/')
  profile_data = Nokogiri::HTML(html)
  students = {}

  # iterate over all student bios and return student profiles
  profile_data.css("div.big-comment h3 a").each do |student|
   name = student.text
   profile_url = student.values.first

   student_html = open('http://web0715.students.flatironschool.com/' + profile_url)
   student_profile_data = Nokogiri::HTML(student_html)

   tagline = student_profile_data.css("div.textwidget h3").text
   work = student_profile_data.css("div.services h4").text
   education = student_profile_data.css("div.services ul li").text

   students[name] = Student.new(name, profile_url, tagline, work, education)
   binding.pry
  end
  students
end

# create student
class Student
  @default = 'no info provided'
  attr_accessor :name, :profile_url, :tagline, :work, :education
  def initialize(name, profile_url, tagline = @default, work = @default, education = @default)
    @name = name
    @profile_url = profile_url
    @tagline = tagline
    @work = work
    @education = education
  end
end

create_student_hash

###### iterate over all student objects and add them to an array
# steven = Student.new(name, tagline, bio)

###### METHODS FOR CLI
class Directory
  attr_reader :students

  def initialize(students)
    @students = students
    engine
  end

  def prompt
    "// "
  end

  def welcome
    puts "\nWelcome to your..."
    puts "*------------------------------------------------*"
    puts "| Flatiron School FooTang Class Directory - 0715 |"
    puts "*------------------------------------------------*"
  end

  def get_user_input
    input = gets.chomp.downcase
  end

  def help
    puts "\nSchool directory accepts the following commands:"
    puts "--------------------------------------------------"
    puts "- help : displays this help message"
    puts "- list : displays a list of all students"
    puts "- exit : exits this program"
  end

  def list
  end

  def student
  end

  def exit_jukebox
    puts "\nTake care.\n\n"
    abort
  end

  def invalid_command
    puts "\nInvalid input, please try again."
    print "Type 'help' for a list of available commands.\n"
  end

  def run
    puts "\nPlease enter a command:"
    print prompt
    input = get_user_input
    case input
      when 'help' then help
      when 'list' then list
      when 'exit' then exit_jukebox
      else invalid_command
    end
  end

  def engine
    welcome
    while true
    ## run the program
    end
  end
end

# directory = Directory.new(student_object_array)
