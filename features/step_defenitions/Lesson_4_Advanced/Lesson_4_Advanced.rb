Then /^Insert the path into input box and click Enter$/ do
  uploadInputBox = $driver.find_element :xpath => "//input[@name = 'userName']"
  filePath = File.join(File.dirname(Dir.pwd), '/fp2/ImageFolder/myfirstscreen.jpg')
  uploadInputBox.send_keys filePath
  $driver.action.key_down :enter
 # uploadInputBox.send_keys :return
end

Then /^Upload Picture using absolute path and Submit$/ do
  uploadInputBox = $driver.find_element :xpath => "//input[@type = 'file']"
  # filePath = File.join(File.dirname(__FILE__), '/../../../ImageFolder/myfirstscreen.jpg')
  #uploadInputBox.send_keys filePath
  uploadInputBox.send_keys "c:\\myfirstscreen.jpg"
  sleep 4
  submitButton = $driver.find_element :xpath => "//input[@type = 'submit']"
  submitButton.click
end

Then /^Upload Picture to input = file and test DIR$/ do
  uploadInputBox = $driver.find_elements :xpath => "//input[@name = 'qqfile']"
  #Dir.pwd returns the full path to project including Projectfolder C:/Users/Katrinka/RubymineProjects/fp2
  #!!!path doesn't work like c:/folder or c:\folder. It works only using c:\\folder
  filePath = File.join(Dir.pwd.tr("/","\\"), '\\ImageFolder\\myfirstscreen.jpg')
  #filePath = File.join(File.dirname(__FILE__).tr("/","\\"), '\\myfirstscreen.jpg')
  puts "filepath " + filePath
  # __FILE__ C:/Users/Katrinka/RubymineProjects/fp2/features/step_defenitions/Lesson_4_Advanced/Lesson_4_Advanced.rb
  puts "__FILE__ " + __FILE__
  puts File.dirname(__FILE__)
  puts "Dir.pwd " + Dir.pwd
  #$driver.execute_script "$('input').show();" is used to show hidden elements on the Page
  uploadInputBox[0].send_keys filePath
end

Then /^Upload several Pictures$/ do
  ImageFolder = "ImageFolder"
  if Dir.exist?(ImageFolder)
    filePath = File.join(Dir.pwd.tr("/", "\\"), "\\#{ImageFolder}")
    Dir.chdir(ImageFolder)
    Dir.glob("*") do |fileName|
      uploadInputBox = $driver.find_elements :xpath => "//input[@name = 'qqfile']"
      uploadInputBox[0].send_keys File.join(filePath, "\\#{fileName}")
    end
  end
end

Then /^Solve the game$/ do
  cards = $driver.find_elements :xpath => "//div[@id = 'cardPile']/div[@class = 'ui-draggable']"
  cardHolders =  $driver.find_elements :xpath => "//div[@id = 'cardSlots']/div[@class = 'ui-droppable']"
  countPlaces = 0
  for everyCard in cards do
    for everyCardHolder in cardHolders do
      $driver.action.drag_and_drop(everyCard, everyCardHolder).perform
      sleep 8
      filledCardHolder = $driver.find_elements :xpath => "//div[@class = 'ui-droppable ui-droppable-disabled ui-state-disabled']"
      puts filledCardHolder.count.to_s
      if filledCardHolder.count > countPlaces
        break
      end
    end
    cards = $driver.find_elements :xpath => "//div[@id = 'cardPile']/div[@class = 'ui-draggable']"
    cardHolders =  $driver.find_elements :xpath => "//div[@id = 'cardSlots']/div[@class = 'ui-droppable']"
    countPlaces += 1
  end
  $driver.save_screenshot('ImageFolder/SuccessfulGameScreen.jpg')
end
