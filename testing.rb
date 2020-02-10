def input_students
  puts "Please enter student information"
  puts "To finish, type stop as name"
  #Create empty array
  students = []
  #array of possible cohorts
  cohorts = ["january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december"]
  #Get the first name
  puts "Name: "
  name = gets.chomp
  puts "Cohort: "
  cohort = gets.chomp.downcase
  #conditional checks that the cohort exists, that there are no typos and returns a default if empty
  if cohorts.include? cohort
    cohort = cohort.to_sym
  elsif cohort.empty?
    cohort = "default".to_sym
  else
    puts "Please enter a valid cohort"
  end
  puts "Height (cm): "
  height = gets.chomp + "cm"
  puts "Country of birth: "
  c_o_b = gets.chomp.upcase
  #while the name is not empty, loop
  while !name.empty? do
    #add a hash of name and cohort to the students array
    students << {name: name, cohort: cohort, height: height, CoB: c_o_b}
    puts "Now we have #{students.count} students"
    #get another student from the user
    puts "Name: "
    name = gets.chomp
    break if name == "stop"
    puts "Cohort: "
    cohort = gets.chomp.downcase
    if cohorts.include? cohort
      cohort = cohort.to_sym
    elsif cohort.empty?
      cohort = "default".to_sym
    else
      puts "Please enter a valid cohort"
      until cohorts.include? cohort
        puts "Cohort: "
        cohort = gets.chomp
      end
    end
    puts "Height (cm): "
    height = gets.chomp + "cm"
    puts "Country of birth: "
    c_o_b = gets.chomp.upcase
  end
  #return the array of students
  students
end

def print_header
  puts "The Students of Villains Academy"
  puts "--------------"
end
def print_names(students)
  students.each_with_index do |student, index|
    puts "#{index +1}. #{student[:name].capitalize.center(10)} #{student[:height]} #{student[:CoB].center(15)} (#{student[:cohort]} cohort)"
  end
end
def print_footer(students)
  puts "--------------"
  puts "Overall, we have #{students.count} great students."
end

students = input_students
#nothing happens until functions are called
print_header
print_names(students)
print_footer(students)
