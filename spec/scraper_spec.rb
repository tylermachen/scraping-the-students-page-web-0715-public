require 'spec_helper'

describe Scraper do
  it "scrapes the index file" do
    scraper = Scraper.new('http://web0715.students.flatironschool.com/')
    scraper.create_student_hash
    expect(scraper.student_elements.count).to eq(27)
  end
end
