describe Directory do
  it "gets number of students" do
    directory = StudentDirectory.new(student_data)
    expect(directory.students).to eq(27)
  end
end
