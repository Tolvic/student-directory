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

def save_students(students)
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Students saved to file."
end

def user_options(students)
  loop do
    puts "**************"
    puts "what would you like to do?"
    puts "1 - print all students"
    puts "2 - Print students whoes name begins with a specific letter"
    puts "3 - Print students whoes name is under a specific character length"
    puts "4 - Ammend a studennt's record"
    puts "5 - print students by cohort"
    puts "6 - Save students to file"
    puts "quit"

    option = gets.chomp
    case option
      when "1"
        print_all(students)
      when "2"
        print_all(filter_by_letter(students))
      when "3"
        print_all(filter_by_char_length(students))
      when "4"
        amend_record(students)
      when "5"
        display_by_cohort(students)
      when "6"
        save_students(students)
      when "quit"
        puts "Good bye"
        break
      end
  end
end


students = input_students
#nothing happens until we call the methods
user_options(students)
