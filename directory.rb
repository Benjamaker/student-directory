#empty array of students available everywhere
@students = []

def input_names
  puts "Name: "
  name = STDIN.gets.chomp
end

def input_cohort
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
  puts "Cohort: "
  cohort = STDIN.gets.chomp.downcase
  #conditional checks that the cohort exists, that there are no typos and returns a default if empty
  if cohorts.include? cohort
    cohort = cohort.to_sym
  elsif cohort.empty?
    cohort = "default".to_sym
  else
    puts "Please enter a valid cohort"
    until cohorts.include? cohort
      puts "Cohort: "
      cohort = STDIN.gets.chomp.downcase
    end
  end
end

def input_height
  puts "Height (cm): "
  height = STDIN.gets.chomp + "cm"
end

def input_c_o_b
  puts "Country of birth: "
  c_o_b = STDIN.gets.chomp.upcase
end

def input_students
  puts "Please enter student information"
  puts "To finish, type stop as name"
  #while the name is not empty, loop
  loop do
    name = input_names
    break if name == "stop"
    #add a hash of student data to the students array
    @students << {name: name, cohort: input_cohort, height: input_height, CoB: input_c_o_b}
    #conditional ensures appropriate sing/plural
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
  end
end

  #return the array of students sorted by cohort
  # @students.sort_by{|student|student[:cohort]}

def show_students
  print_header
  print_names
  print_footer
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:height], student[:CoB]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, height, c_o_b = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym, height: height, CoB: c_o_b}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def print_menu
  puts "1. Input students"
  puts "2. View the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "Please select a valid option from the menu"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_header
  puts "The Students of Villains Academy"
  puts "--------------"
end

def print_names
  @students.each_with_index do |student, index|
    puts "#{index +1}. #{student[:name].capitalize.center(10)} #{student[:height]} #{student[:CoB].center(15)} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "--------------"
  if @students.count == 1
    puts "Overall, we have 1 great student."
  elsif @students.count > 1
    puts "Overall, we have #{@students.count} great students."
  end
end

try_load_students
interactive_menu
