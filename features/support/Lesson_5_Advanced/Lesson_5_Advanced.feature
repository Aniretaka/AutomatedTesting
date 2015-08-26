Feature: Working with SVG

  Scenario: Working with svg in iframe
    Given Go to http://bl.ocks.org/mbostock/3943967 page
    Then Working with iframe

  #Output low/mid/high percentage for each state
  Scenario: Output low/mid/high percentage for each state disaplyed on SVG
    Given Go to http://bl.ocks.org/NPashaP/96447623ef4d342ee09b page
    Then In each state output low,mid,high percentage