# scraper
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'faker'

=begin
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
=end

def create_student_hash
  url = 'http://web0715.students.flatironschool.com/'
  begin
    html = open(url)
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
    end
  rescue OpenURI::HTTPError => e
    if e.message == '404 Not Found'
      puts "EXPLODE!!!!"
    end
  end

  students
end

completed_hash = create_student_hash

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

=begin
students = {}
students["John Smith"] = Student.new('John Smith', nil,'Living the good life', 'Harvard', 'CEO')
students["Seymore Butts"] = Student.new('Seymore Butts',nil, 'Living the best life!', 'MIT', 'Chicken Sexer')
students["Bill Bonovan"] = Student.new('Bill Bonovan', nil, 'Living an even better life.', 'Yale', 'Jedi Master')
=end
###### iterate over all student objects and add them to an array
# steven = Student.new(name, tagline, bio)

###### METHODS FOR CLI
class Directory
  attr_accessor :students

  def initialize(students)
    @students = students
    engine
  end

  def prompt
    print "> "
  end

  def welcome
    puts "\nWelcome to your..."
    puts "*------------------------------------------------*"
    puts "| Flatiron School FooTang Class Directory - 0715 |"
    puts "*------------------------------------------------*"
  end

  def get_user_input
    prompt
    input = gets.chomp.downcase
    case input
      when 'list' then list
      when 'help' then help
      else abort
    end
  end

  def help
    puts "\nSchool directory accepts the following commands:"
    puts "--------------------------------------------------"
    puts "- help : displays this help message"
    puts "- list : displays a list of all students"
    puts "- exit : exits this program"
  end

  def list
    puts "All Students"
    puts "------------"
    @students.keys.each.with_index(1) do |student, index|
      puts "#{index}. #{student} - #{@students[student].work} - #{@students[student].education}"
    end
    # puts "\nPlease enter a student number or name to see student profile."
  end

  def exit_directory
    puts "\nTake care.\n\n"
    abort
  end

  def invalid_command
    puts "\nInvalid input, please try again."
    print "Type 'help' for a list of available commands.\n"
  end

  def school
  end

  def engine
    welcome
    help
    while true
      get_user_input
    end
    exit_directory
  end
end

directory = Directory.new(completed_hash)
directory
