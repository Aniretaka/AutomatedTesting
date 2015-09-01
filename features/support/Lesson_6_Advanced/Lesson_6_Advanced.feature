Feature: Working with files

  Scenario: Login to site using different credentials
    Given Go to http://grigoshin.com/cmpanel page
    Then Login using different credentials

  Scenario: Reading through files
    Then Check if the file contains The move greatly increases sequence