# encoding: UTF-8
#Line above is for understanding Russian language in Xpath

def toUtf8(str)
  str = str.force_encoding('UTF-8')
  return str if str.valid_encoding?
  str.encode("UTF-8", 'binary', invalid: :replace, undef: :replace, replace: '')
end

Then /^Login using different credentials$/ do
  #1) spreadsheet gem DO NOT support xlsx-format, try to use RubyXL gem
  #2) close xls-file if opened otherwise error will occur
  login = $driver.find_element(:xpath, "//input[@name = 'username']")
  password = $driver.find_element(:xpath, "//input[@name = 'password']")
  book = Spreadsheet.open 'c:\New\LoginPassword.xls'
  firstWorkSheet= book.worksheet('First')
  #Commented below code can be used to work with cells and columns
=begin
  a = firstWorkSheet.column 1
  b = firstWorkSheet.cell 1, 2
  puts "____"
  puts b
  for i in a
    puts i
  end
=end
  firstWorkSheet.each do |row|
    login.send_key row[0]
    password.send_key row[1]
    $driver.find_element(:xpath, "//input[@type = 'submit']").click
    exitLink = $driver.find_elements(:xpath, "//a[.//u[text() = 'Выход']]")
    if exitLink.count > 0
      exitLink[0].click
      puts "User with login and password: %s %s is logged in" %[row[0],row[1]]
      if row[2].include? "yes"
        puts "It is correct"
      else
        puts "BUG: It is INcorrect"
      end
      puts "______________"
    else
      puts "User with login and password: %s %s is NOT logged in" %[row[0],row[1]]
      if row[2].include? "no"
        puts "It is correct"
      else
        puts "BUG: It is INcorrect"
      end
      puts "______________"
    end
    login = $driver.find_element(:xpath, "//input[@name = 'username']")
    password = $driver.find_element(:xpath, "//input[@name = 'password']")
    login.clear
    password.clear
  end
end

Then /^Check if the file contains ([^"]*) sequence/ do |searchValue|
  # there is no difference between each and each_line, each_line is used to clarify (ruby has each_char, each_byte)
  fileFolder = "ImageFolder"
  if Dir.exist?(fileFolder)
     Dir.chdir(fileFolder)
     Dir.glob("*.txt").each do |fileName|
        File.open(fileName, "r").each do |line|
          line = toUtf8(line)
          puts 'Got the sequence: "' + searchValue + '" in the line: %s in the file:%s' %[line, fileName] if (line[/#{searchValue}/])
        end
     end
  end
end
