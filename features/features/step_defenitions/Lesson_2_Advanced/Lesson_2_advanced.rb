def findSearchValue (stringToFind, arrayOfElements)
  wordsToFind = stringToFind.split(/\W+/)
  isElementCorrect = true
  for element in arrayOfElements
    isWordFound = 0
    index = 0
    while index <= wordsToFind.count-1
      if element.text.include? wordsToFind[index]
        isWordFound = 1
      end
      index += 1
    end
    if isWordFound == 0
      puts '!!!  Something is wrong with an element. Nothing is found by the query '+ "\'" + stringToFind + "\'" + ' in the element:' + "\n" + element.text
      puts '!!! Failed: Search is incorrect.'
      isElementCorrect = false
    end
  end
  return isElementCorrect
end

def receiveElementsOnPage
  elementsOnPage = $driver.find_elements :xpath => "//li[@class='sresult lvresult clearfix li']"
  return elementsOnPage
end

Given /^Go to ebay Cars-Trucks ([^"]*) page$/ do |url|
  $driver.get url
end

And /^Set ([^"]*) language if not$/ do |langName|
  currentLang = $driver.find_element :xpath=> "//span[@class = 'gh-eb-Geo-flag gh-sprRetina'][text()!='']"
  unless currentLang.text.include? langName
    $driver.mouse.move_to currentLang
    newLang = $driver.find_element :xpath => "//a[./span[text()='#{langName}']]"
    newLang.click
  end
end

Given /Print cars if they are not ([^"]*) on first ([^"]*) pages$/ do |includingString,pageQuantity|
  currentPageIndex = 2
  while currentPageIndex <= pageQuantity.to_i do
    cars = $driver.find_elements :xpath => "//h3/a"
    for car in cars
      unless car.text.include? includingString
        puts car.text
      end
    end
    currentPage = $driver.find_element :xpath => "//td[@class = 'pages']/a[text() = '#{currentPageIndex}']"
    currentPage.click
    currentPageIndex += 1
  end
end

Given /^Input in Search field ([^@]*)$/ do |searchValue|
  searchField = $driver.find_element :xpath => "//input[@class='gh-tb ui-autocomplete-input']"
  searchField .send_keys "#{searchValue}"
end

When  /^Press Search button$/ do
  searchButton = $driver.find_element :xpath => "//input[@value='Search']"
  searchButton.click
end

Then /^Verify Search results contains the word ([^@]*)$/  do |searchValue|

  pages = $driver.find_elements :xpath => "//td[@class = 'pages']/a"
  cars = receiveElementsOnPage
  isAllElementsCorrect = true
  isNoResults = false
  if pages.count > 1
    currentPageIndex = 2
    while currentPageIndex <= pages.count do
      isAllElementsCorrect = isAllElementsCorrect && findSearchValue(searchValue, cars)
      currentPage = $driver.find_element :xpath => "//td[@class = 'pages']/a[text() = '#{currentPageIndex}']"
      currentPage.click
      currentPageIndex += 1
      cars = receiveElementsOnPage
    end
  else
    if cars.count > 0
      isAllElementsCorrect = isAllElementsCorrect && findSearchValue(searchValue, cars)
    else
      isNoResult = true
      puts '!!! Passed: Search is correct. Nothing is found by the query '+ "\'" + searchValue + "\'"
    end
  end

  if isAllElementsCorrect && !isNoResult
  puts '!!! Passed: Search is correct. All displayed elements are correspond to the input value ' + "\'" + searchValue + "\'"
  end
end

