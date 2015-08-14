Feature: Lesson_2_Advanced
#Task 1: (while loop + for)
#url: http://www.ebay.com/sch/Cars-Trucks-/6001/i.html
#what to do: Print cars if they are not “NEW LISTING” on first 4 pages

#Task 2: (For loop + array)
#url: http://www.ebay.com/sch/Cars-Trucks-/6001/i.html
#what to do: Create a list of requests and use them one by one in ebay.search. After each search verify that its results matched with given request

  Background: Going to the specified page
    Given Go to ebay Cars-Trucks http://www.ebay.com/sch/Cars-Trucks-/6001/i.html page
    And   Set English language if not

  Scenario: Print cars if they are not "NEW LISTING" on first 4 pages
   Then  Print cars if they are not NEW LISTING on first 4 pages

  Scenario Outline: Verify Search Results
    And   Input in Search field <value>
    And   Press Search button
    Then  Verify Search results contains the word <value>
    Examples: Item values
       |                        value                         |
       |Ford : F-350 XLT                                      |
       |Chevrolet : Silverado 2500 LT Certified 2014 15K MILES|
       |1997                                                  |
       |Atlanta, GA                                           |
       |Ford 1997                                             |
       |vnhghjg                                               |