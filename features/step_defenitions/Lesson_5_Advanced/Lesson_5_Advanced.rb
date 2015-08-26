def elementReturn (tdText, tdClass)
  element = $driver.find_element :xpath => "//table[@class = 'legend']//td[contains(text(),'#{tdText}')]/following-sibling::td[@class = '#{tdClass}']"
  return element
end

Then /^Working with iframe$/ do
  $driver.switch_to.frame $driver.find_element(:xpath, "//iframe[not(@id = 'rdbIndicator')]")
  svg  = $driver.find_element(:xpath, "//*[name() = 'svg']")
  puts svg.attribute("height")
end

Then /^In each state output low,mid,high percentage$/ do
  count = 1
  $driver.switch_to.frame $driver.find_element(:xpath, "//iframe[not(@id = 'rdbIndicator')]")
  barsArray  = $driver.find_elements(:xpath, "//*[name() = 'svg']//*[name() = 'g'][@class = 'bar']/*[name() = 'rect']")
  for everyBar in barsArray
    $driver.mouse.move_to everyBar
    barText = everyBar.find_element :xpath => "./following-sibling::*[name() = 'text']"
    # Do NOT do like string commented below - don't mix svg and ordinary xpath because table tag is outside svg
    #lowFreq = everyBar.find_element :xpath => "./ancestor::*[name() = 'svg']/following-sibling::*[name() = 'table'][@class = 'legend']//*[name() = 'td'][contains(text(),'low')]/following-sibling::*[name() = 'td'][@class = 'legendFreq']"
    lowFreq = elementReturn('low','legendFreq')
    lowPerc = elementReturn('low','legendPerc')
    midFreq = elementReturn('mid','legendFreq')
    midPerc = elementReturn('mid','legendPerc')
    highFreq = elementReturn('high','legendFreq')
    highPerc = elementReturn('high','legendPerc')
    puts count.to_s + " Bar Value: %s  low %s %s mid %s %s high %s %s" %[barText.text, lowFreq.text, lowPerc.text, midFreq.text, midPerc.text, highFreq.text, highPerc.text]
    count += 1
  end
end

