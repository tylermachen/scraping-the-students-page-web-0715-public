class Student
  attr_reader :default, :name, :profile_url, :tagline, :bio, :work, :education
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
