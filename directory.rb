#put students into an array
students = [
 "Dr. Hannibal Lecter",
 "Darth Vader",
 "Nurse Ratched",
 "Michael Corleone",
 "Alex DeLarge",
 "The Wicked Witch of the West",
 "Terminator",
"Freddy Krueger",
"The Joker",
"Joffrey Baratheon",
"Norman Bates"]

#then we print the list of students
puts "The students of Villians Academy"
puts "-------------"
students.each do |student|
  puts student
end
#finally we puts the total number of students
puts "Overall, we have #{students.count} great students"
