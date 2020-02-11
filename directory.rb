def interactive_menu
  students = []
  loop do
    #print the menu and ask the user what to do
    puts "1. Input students"
    puts "2. View the students"
    puts "9. Exit"
    #read input and save as variable
    selection = gets.chomp
    #do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print_names(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "Please select a valid option from the menu"
    end
  end
end
    #repeat from step 1

def input_students
  #Create empty array
  students = []
  #array of possible cohorts
  cohorts = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    "december"
  ]
  puts "Please enter student information"
  puts "To finish, type stop as name"
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
    until cohorts.include? cohort
      puts "Cohort: "
      cohort = gets.chomp.downcase
    end
  end
  puts "Height (cm): "
  height = gets.chomp + "cm"
  puts "Country of birth: "
  c_o_b = gets.chomp.upcase
  #while the name is not empty, loop
  while !name.empty? do
    #add a hash of name and cohort to the students array
    students << {name: name, cohort: cohort, height: height, CoB: c_o_b}
    #conditional ensures appropriate sing/plural
    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
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
        cohort = gets.chomp.downcase
      end
    end
    puts "Height (cm): "
    height = gets.chomp + "cm"
    puts "Country of birth: "
    c_o_b = gets.chomp.upcase
  end
  #return the array of students sorted by cohort
  students.sort_by{|student|student[:cohort]}
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
  if students.count == 1
    puts "Overall, we have 1 great student."
  elsif students.count > 1
    puts "Overall, we have #{students.count} great students."
  end
end

interactive_menu
