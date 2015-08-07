=begin THIS ONE HANDLES 404 ERRORS
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
      binding.pry
    end
  rescue OpenURI::HTTPError => e
    if e.message == '404 Not Found'
      puts "EXPLODE!!!!"
    end
  end
end
=end

=begin ORIGINAL WORKING METHOD WHEN SITE WORKS
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

=begin
# SAMPLE FAKE DATA TO PLAY WITH
students = {}
students["John Smith"] = Student.new('John Smith', nil,'Living the good life',nil, 'Harvard', 'CEO')
students["Seymore Butts"] = Student.new('Seymore Butts',nil, 'Living the best life!',nil, 'MIT', 'Chicken Sexer')
students["Bill Bonovan"] = Student.new('Bill Bonovan', nil, 'Living an even better life.',nil, 'Yale', 'Jedi Master')
=end
