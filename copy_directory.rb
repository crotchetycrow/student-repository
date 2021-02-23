#put students into an array
# students = [
#  {name: "Dr. Hannibal Lecter", cohort: :november},
#  {name:"Darth Vader", cohort: :november},
#  {name:"Nurse Ratched", cohort: :november},
#  {name:"Michael Corleone", cohort: :november},
#  {name:"Alex DeLarge", cohort: :november},
#  {name:"The Wicked Witch of the West", cohort: :november},
#  {name:"Terminator", cohort: :november},
#  {name:"Freddy Krueger", cohort: :november},
#  {name:"The Joker", cohort: :november},
#  {name:"Joffrey Baratheon", cohort: :november},
#  {name:"Norman Bates", cohort: :november}
# ]

def input_students
  puts "Please enter the name of the students"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add student hash to the array
    students << {name: name, cohort: :novemeber}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villians Academy"
  puts "-------------"
end

def print(students)
  puts "Enter a specific letter: "
  user_input_letter = gets.chomp
  i = 0
  students.each do |student|
    if student[:name].start_with?(user_input_letter.upcase, user_input_letter.downcase)
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
      i += 1
    else
    end
  end
  puts "Overall, we have #{i} students with the letter #{user_input_letter}"
end



students = input_students
print_header
print(students)
