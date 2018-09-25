@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  i = 0
  while !name.empty? do
    puts "Please enter cohort:"
    cohort = gets.chomp
    puts "date of birth:"
    dob = gets.chomp
    dob = "TBC" if dob == ""
    # add the student hash to the array
    students << {id: i.to_s.to_sym, name: name, cohort: cohort.to_sym, dob: dob.to_sym}
    puts "Now we have #{students.count} students"
    # get another name from the user
    i+=1
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end


def print_students(students)
  students.each_with_index do |student,index|
    puts "#{index+1}. ID: #{student[:id]} Name: #{student[:name]} Cohort: #{student[:cohort]} DOB: #{student[:dob]}"
  end
end


def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def print_all(students)
  print_header
  print_students(students)
  print_footer(students)
end

def filter_by_letter(students)
  puts "Enter a letter."
  letter = gets.chomp
  return students.select{ |student| student[:name][0] == letter}
end

def filter_by_char_length(students)
  puts "what character length would you like to filter with?"
  len = gets.chomp.to_i
  return students.select{ |student| student[:name].length <= len}
end

def amend_record(students)
  puts "Please enter the ID of the student you would like to ammend"
  id = gets.chomp
  id = id.to_s.to_sym
  puts "what would you like to ammend?"
  students.select{ |student| student[:id] == id}[0].keys.each { |key|
    puts key unless key.to_s == "id"
  }
  ammend = gets.chomp
  students

end

def display_by_cohort(students)
  cohorts = Hash.new
  students.each { |arr|
    if cohorts.key?(arr[:cohort])
      cohorts[arr[:cohort]] << arr
    else
      cohorts[arr[:cohort]] = [arr]
    end
  }
  cohorts.each { |key, value|
    puts "*** #{key} ***"
    value.each { |value|
      puts "ID: #{value[:id]} Name: #{value[:name]} Cohort: #{value[:cohort]} DOB: #{value[:dob]}"
    }
  }

end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Students saved to file."
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def user_options(students)
  loop do
    puts "**************"
    puts "what would you like to do?"
    puts "1 - print all students"
    puts "2 - Print students whoes name begins with a specific letter"
    puts "3 - Print students whoes name is under a specific character length"
    puts "4 - print students by cohort"
    puts "5 - return to main menu"
    puts "**************"

    option = gets.chomp
    case option
      when "1"
        print_all(students)
      when "2"
        print_all(filter_by_letter(students))
      when "3"
        print_all(filter_by_char_length(students))
      when "4"
        display_by_cohort(students)
      when "5"
        break
      else
        puts "Please enter a valid option."
      end
  end
end

def menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "**************"
    puts "What would you like to do?"
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the students to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit" # 9 because we'll be adding more items
    puts "**************"
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      @students = input_students
    when "2"
      user_options(@students)
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end

end



#nothing happens until we call the methods
menu
