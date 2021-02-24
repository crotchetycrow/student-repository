#create instance variable width that inputs the width I want centre to be
@width = 55
#stores studentss in an array creates instance variable
@students = []
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

def input_cohort
  puts "Please enter cohort month (please enter month number)".center(@width)
  cohort = gets.chomp
  next_cohort = :February

  case cohort
  when "1"
    cohort = :January
  when "2"
    cohort = :February
  when "3"
    cohort = :March
  when "4"
    cohort = :April
  when "5"
    cohort = :May
  when "6"
    cohort = :June
  when "7"
    cohort = :July
  when "8"
    cohort = :August
  when "9"
    cohort = :September
  when "10"
    cohort = :October
  when "11"
    cohort = :November
  when "12"
    cohort = :December
  else
    puts "Invalid input. Student placed in next available cohort, #{next_cohort}"
    cohort = next_cohort
  end
  cohort
end

#refactoring with a ternary operator (must use more often)
#takes the count and if it = to 1 then it will interpolate the string it receives
#with singlular student, if more than 1 it will pluralize
def pluralize_string(count)
  count == 1 ? "#{count} student" : "#{count} students"
end


def input_students
  #creates a variable that triggers create_directory method
  begin_directory = create_directory

  while begin_directory
    number_student = 0
    #grabs user input for name and country, height
    puts "Please enter the name of the students".center(@width)
    name = gets.chomp
    if name.empty?
      puts "Invalid input, student stored as Student Number: #{number_student += 1}".center(@width)
    end
    cohort = input_cohort
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
    @students << {name: name, country_of_birth: country_of_birth, height: height, hobbies: hobbies.join(", "), cohort: cohort.to_sym}
    #counts number of students
      puts "Now we have #{pluralize_string @students.count}".center(@width)
    #creates a variable that triggers create_directory to give user option to end
    begin_directory = create_directory
  end
  @students
end

def print_student_list_by_cohort(students)
  if @students.empty?
    puts "UNAVAILABLE".center(@width)
  else
    cohorts = @students.map do |student|
      student[:cohort]
    end
    cohorts.uniq.each do |cohort|
      puts "#{cohort} cohort".upcase.center(@width)
        @students.each do |student|
          if student[:cohort] == cohort
            puts student[:name].center(@width)
          end
        end
    end
  end
end


def print_header
  puts "The students of Villians Academy".center(@width)
  puts "-------------".center(@width)
  puts
end

#method to count number of students and puts name, country...
def print(students)
  i = 0
  while i < @students.count
    puts "#{@students[i][:name]}, #{@students[i][:country_of_birth]}, #{@students[i][:height]} cm, #{@students[i][:hobbies]} - (#{@students[i][:cohort]} cohort)".center(@width)
    i += 1
  end
end

#method to output overall total of students
def print_footer(names)
  puts
  puts "Overall, we have #{pluralize_string names.count}".center(@width)
  puts "-------------".center(@width)
  puts
end

@students = input_students
print_header
print(@students)
print_footer(@students)
print_student_list_by_cohort(@students)
