#####Instance variables#####
#create instance variable width that inputs the width I want centre to be
@width = 55
#stores students in an array creates instance variable
@students = []

@default_filename = "students.csv"

@loaded_filename = ""
######Input######

#request input from user to add a new student
def create_directory
  puts "Input a new student? 'YES' or 'NO'".center(@width)
  user_input = STDIN.gets.chop.upcase
  if user_input == "YES"
    return true
  elsif user_input == "NO"
    return false
  else
    error_msg
    puts "Did not understand input. Please input 'YES' or 'NO'".center(@width)
    error_msg
    puts
  end
  #returns method to start again
  create_directory
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      puts "Which file would you like to save to? (for example 'students.csv')"
      select_save = STDIN.gets.chomp
      if select_save.empty?
        save_students
      else
        save_students(select_save)
      end
    when "4"
      puts "Which file would you like to load? (for example 'students.csv')"
      select_load = STDIN.gets.chomp
      if select_load.empty?
        load_students
      else
        load_students(select_load)
      end
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def input_cohort
  puts "Please enter cohort month (please enter month number)".center(@width)
  cohort = STDIN.gets.chomp
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


def input_students
  #creates a variable that triggers create_directory method
  begin_directory = create_directory

  while begin_directory
    #grabs user input for name and country, height
    puts "Please enter the name of the students".center(@width)
    name = STDIN.gets.chop
    action_success
    if name.empty?
      puts "No input"
      break
    end
    cohort = input_cohort
    action_success
    puts "Please enter country of birth".center(@width)
    country_of_birth = STDIN.gets.chop
    action_success
    puts "Please enter height in cm (if available)".center(@width)
    height = STDIN.gets.chop
    action_success
    #grab user input for hobbies and stores it in an empty array. Join used to convert into string
    hobbies = []
    puts "Please enter student's hobbies".center(@width)
    puts "(To finish, just hit return twice)".center(@width)
    hobby = STDIN.gets.chop
    action_success
    while !hobby.empty?
      hobbies << hobby
      hobby = STDIN.gets.chop
    end
    hobbies
    #pushes name, country, cohort and hobbies onto students array
    add_students(name, country_of_birth, height, hobbies.join(", "), cohort.to_sym  )
    #counts number of students
    puts "Now we have #{pluralize_string @students.count}".center(@width)
    #creates a variable that triggers create_directory to give user option to end
    begin_directory = create_directory
  end
  @students
end

def print_student_list_by_cohort(students)
  if @students.empty?
    puts "COHORT LIST UNAVAILABLE".center(@width)
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

def add_students(name, country_of_birth, height, hobbies, cohort)
  @students << {name: name, country_of_birth: country_of_birth, height: height, hobbies: hobbies, cohort: cohort}
end

#####Tools#####

#refactoring with a ternary operator (must use more often)
#takes the count and if it = to 1 then it will interpolate the string it receives
#with singlular student, if more than 1 it will pluralize
def pluralize_string(count)
  count == 1 ? "#{count} student" : "#{count} students"
end

def error_msg
  puts "!----ERROR----!".center(@width)
end

def divider
   puts "-------------".center(@width)
end

def action_success
  puts "Input saved".center(@width)
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save list to students.csv"
  puts "4. Load student list"
  puts "9. Exit"
end

#method to count number of students and puts name, country...
def print_student_list
  if @students.empty?
    puts "No students inputted".upcase.center(@width)
  else
    i = 0
    while i < @students.count
      puts "#{@students[i][:name]}, #{@students[i][:country_of_birth]}, #{@students[i][:height]}cm, #{@students[i][:hobbies]} - (#{@students[i][:cohort]} cohort)".center(@width)
      i += 1
    end
  end
end

def print_header
  if !@students.empty?
    puts "The students of Villians Academy".center(@width)
    divider
    puts
  else
    puts "The students of Villians Academy".center(@width)
    divider
    puts
  end
end

#method to output overall total of students
def print_footer
  puts
  puts "Overall, we have #{pluralize_string @students.count}".center(@width)
  divider
  puts
end

def show_students
  print_header
  print_student_list
  print_footer
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

#####Save/Load######

require 'csv'

def save_students(filename = @default_filename)
  # open the file for writing
  #open file for writing using csv class
  csv.open(filename, "wb") do |csv|
  # iterate over the array of students
  @students.each do |student|
    csv << [student[:name], student[:country_of_birth], student[:height], student[:hobbies], student[:cohort]]
  end
  @loaded_filename
  end
  file.close
  puts "#{filename} saved".center(@width)
  divider
end


def load_students(filename = @default_filename)
  if File.exists?(filename)
    CSV.foreach(filename) do |row|
      name, country_of_birth, height, hobbies, cohort = row
      add_students(name, country_of_birth, height, hobbies, cohort)
    file.close
  end
  @loaded_filename = filename
  puts "#{filename} loaded".center(@width)
  divider
  else
   if filename == @default_filename
     puts "The default file #{@default_filename} was not found"
     File.write("students.csv", "")
     @loaded_filename = filename
     puts "A new #{@default_filename} was created"
   else
     puts "#{error_msg} File #{filename} not found".center(@width)
     puts
     puts "Loading #{@loaded_filename}".center(@width)
   end
 end
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil?
    puts
    puts "Loading default file...".center(@width)
    puts
    @loaded_filename = @default_filename
    load_students
    return
  end
  if File.exists?(filename) # if it exists
    @loaded_filename
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}".center(@width)
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist.".center(@width)
    exit # quit the program
  end
end

#####Execute#####

try_load_students
interactive_menu
