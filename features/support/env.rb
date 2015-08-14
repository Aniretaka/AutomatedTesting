require 'rubygems'
require 'selenium-webdriver'
require 'cucumber'

Before do |scenario|
  $driver = Selenium::WebDriver.for :firefox
  $driver.manage.window.maximize
  $driver.manage.timeouts.implicit_wait = 10
end

After do |scenario|
   $driver.close
end

