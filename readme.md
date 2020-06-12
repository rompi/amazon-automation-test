# Application Test Case
This is an example of automation test for Amazon website, based on sign in and sign up feature. The script is written in ruby, and using Gherkin format. There are 2 scenarios for each feature. Here is the scenario:

 - Sign Up:
	 - Sign Up Ok, with code @SU_001
	 - Sign Up Failed (invalid email address), with code @SU_002
 - Sign In:
	 - Sign In Ok, with code @SI_001
	 - Sign In Failed (incorrect password), with code @SI_002

# How To Run

 1. To run the automation test, you should have ruby and cucumber installed on your machine. Also, you need to install chromedriver to automate the browser. Here are some resources you can follow:
		 - http://mbatin.com/post/5-langkah-belajar-automation-test-selenium-cucumber-gherkin
		 - https://github.com/SeleniumHQ/selenium/wiki/Ruby-Bindings
 2. Once you have the ruby, cucumber, and chromedriver installed on your machine, you just need to clone this repository to your machine
 3. Change your working directory to the root of this project
 4. Run this command `cucumber -f pretty -f html -o report.html`
	 - or if you want to run it by specific scenario, you can add `--tags {scenario tag}`, ex: `cucumber -f pretty -f html -o report.html --tags SU_001`
 5. The output will be written in console. However, it will generates a new file named `report.html`, and you can see the report on your browser by opening the file.
 
 Thank you