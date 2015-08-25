Feature: Working with drag and drop and upload files

  Scenario: Working with uploads without Submit
    Given Go to https://angular-file-upload.appspot.com/ page
    Then Upload Profile Picture

  Scenario: Working with uploads with Submit
    Given Go to http://cgi-lib.berkeley.edu/ex/fup.html page
    Then Upload Picture and Submit

  Scenario: Upload Picture to input = file element
    Given Go to http://fineuploader.com/demos page
    Then Upload Picture to input = file

  Scenario: Upload directory with images
    Given Go to http://fineuploader.com/demos page
    Then Upload several Pictures

   #Create a script which solves the game
  Scenario: Working with simple drag and drop
    Given Go to http://www.elated.com/res/File/articles/development/javascript/jquery/drag-and-drop-with-jquery-your-essential-guide/card-game.html page
    Then Solve the game