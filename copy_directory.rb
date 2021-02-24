#create instance variable width that inputs the width I want centre to be
@width = 55

#request input from user to add a new student
def create_directory
  puts "Input a new student? 'YES' or 'NO'".center(@width)
  user_input = gets.chomp.upcase
  if user_input == "YES"
    return true
  elsif user_input == "NO"
    return false
  else
    "Did not understand input".center(@width)
  end
  #returns method to start again
  create_directory
end

def input_students
  #stores studentss in an array
  students = []
  #creates a variable that triggers create_directory method
  begin_directory = create_directory

  while begin_directory
    #grabs user input for name and country, height
    puts "Please enter the name of the students".center(@width)
    name = gets.chomp
    puts "Please enter country of birth".center(@width)
    country_of_birth = gets.chomp
    puts "Please enter height in cm (if available)".center(@width)
    height = gets.chomp
    #grab user input for hobbies and stores it in an empty array. Join used to convert into string
    hobbies = []
    puts "Please enter student's hobbies".center(@width)
    puts "(To finish, just hit return twice)".center(@width)
    hobby = gets.chomp
    while !hobby.empty?
      hobbies << hobby
      hobby = gets.chomp
    end
    hobbies
    #pushes name, country, cohort and hobbies onto students array
    students << {name: name, country_of_birth: country_of_birth, height: height, hobbies: hobbies.join(", "), cohort: :november}
    #counts number of students
    puts "Now we have #{students.count} students".center(@width)
    #creates a variable that triggers create_directory to give user option to end
    begin_directory = create_directory
  end
  students
end

def print_header
  puts "The students of Villians Academy".center(@width)
  puts "-------------".center(@width)
end

#method to count number of students and puts name, country...
def print(students)
  i = 0
  while i < students.count
    puts "#{students[i][:name]}, #{students[i][:country_of_birth]}, #{students[i][:height]}, #{students[i][:hobbies]} - (#{students[i][:cohort]} cohort)"
    i += 1
  end
end

#method to output overall total of students
def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(@width)
end

students = input_students
print_header
print(students)
print_footer(students)
