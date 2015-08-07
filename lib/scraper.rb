class Scraper
  attr_reader :students

  def initialize(url)
    @url = url
    @students = {}
    create_student_hash
  end

  def get_student_index_page
    html = open(@url)
    Nokogiri::HTML(html)
  end

  def create_student_hash
    profile_data = get_student_index_page
    
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

        @students[@name] = Student.new(@name, @profile_url, tagline, bio, work, education)
      rescue OpenURI::HTTPError => e
        if e.message == '404 Not Found'
          @students[@name] = Student.new(@name, @profile_url)
          next
        end
      end
    end
  end
end
