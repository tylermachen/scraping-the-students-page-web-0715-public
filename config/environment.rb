$LOAD_PATH << '.'
require 'open-uri'
require 'nokogiri'

require 'lib/scraper'
require 'lib/directory'
require 'lib/student'

url = 'http://web0715.students.flatironschool.com/'
student_data = Scraper.new(url).students
StudentDirectory.new(student_data).run
