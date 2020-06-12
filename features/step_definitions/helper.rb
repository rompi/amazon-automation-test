require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--start-maximized')
driver = Selenium::WebDriver.for :chrome, options: options
driver.manage.timeouts.implicit_wait = 5

$amazon_signup_url = 'https://www.amazon.com/ap/register?showRememberMe=true&openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.com%2F%3Fref_%3Dnav_signin&prevRID=XCK18XB72VR0CX69R2F7&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.assoc_handle=usflex&openid.mode=checkid_setup&prepopulatedLoginId=&failedSignInCount=0&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&pageId=usflex&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0'
$amazon_signin_url = 'https://www.amazon.com/ap/signin?openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.com%2F%3Fref_%3Dnav_signin&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.assoc_handle=usflex&openid.mode=checkid_setup&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&'

Given(/^I open amazon web signin page$/) do
  driver.navigate.to $amazon_signin_url
end

And(/^I input email on signin (.*)$/) do | email |
  element = find_element_by_xpath(driver, '//*[@id="ap_email"]')
  element.send_keys email
  element.submit
end

And(/^I input password on signin (.*)$/) do | password |
  element = find_element_by_xpath(driver, '//*[@id="ap_password"]')
  element.send_keys password
  element.submit
end

Then(/^I should see error message (.*)$/) do | error_message |
  error_message = find_element_by_xpath(driver, '//*[@id="auth-error-message-box"]/div/h4')
  if error_message.text != error_message
    fail(ArgumentError.new('Error Message Not Found'))
  end
end

Then(/^I should see password error message (.*) or captcha confirmation message (.*)$/) do | error_message, captcha_confirm_message |
  begin
    password_error_message = find_element_by_xpath(driver, '//*[@id="auth-error-message-box"]/div/div/ul/li/span')
    if password_error_message.text != error_message
      fail(ArgumentError.new('Password Error Message Not Found'))
    end
  rescue
    check_captcha_validation(driver, captcha_confirm_message)
  end
end

Given(/^I open amazon web signup page$/) do
  driver.navigate.to $amazon_signup_url
end

And(/^I input name on signup(.*)$/) do | name |
  element = find_element_by_xpath(driver, '//*[@id="ap_customer_name"]')
  element.send_keys name
end

And(/^I input email on signup (.*)$/) do | email |
  element = find_element_by_xpath(driver, '//*[@id="ap_email"]')
  element.send_keys email
end

And(/^I input password on signup (.*)$/) do | password |
  element = find_element_by_xpath(driver, '//*[@id="ap_password"]')
  element.send_keys password
end

And(/^I input password confirmation on signup (.*)$/) do | password |
  element = find_element_by_xpath(driver, '//*[@id="ap_password_check"]')
  element.send_keys password
  element.submit
end

Then(/^I see verify email page on signup (.*) (.*) or signup captcha validation (.*)$/) do | verify_message, email , captcha_validation_message|
  begin
    element = find_element_by_xpath(driver, '//*[@id="cvf-page-content"]/div/div/div[1]/form/div[1]/div[2]/span')
    if element.text != verify_message + " " + email
      fail(ArgumentError.new('Verification page Not Found'))
    end
  rescue
    element = find_element_by_xpath(driver, '//*[@id="cvf-page-content"]/div/div/div/div[1]/span')
    if element.text != captcha_validation_message
      fail(ArgumentError.new('Captcha Validation Message Not Found'))
    end
  end
end

Then(/^I see invalid email error message on signup (.*)$/) do | error_message |
  element = find_element_by_xpath(driver, '//*[@id="auth-email-invalid-email-alert"]/div/div')
  if element.text != error_message
    fail(ArgumentError.new('Invalid Password Error Message Not Found'))
  end
end

Then(/^I should see otp page (.*) or captcha confirmation message (.*)$/) do | message, captcha_confirm_message |
  begin
    check_otp_validation(driver, message)
  rescue
    check_captcha_validation(driver, captcha_confirm_message)
  end
end

def check_otp_validation(driver, message)
  otp_confirmation = find_element_by_xpath(driver,'//*[@id="cvf-page-content"]/div[1]/div/div/form/div[2]')
  if otp_confirmation.text != message
    fail(ArgumentError.new('OTP Page Not Found'))
  end
end

def check_captcha_validation(driver, message)
  captcha_confirmation = find_element_by_xpath(driver, '//*[@id="auth-warning-message-box"]/div/div/ul/li/span')
  if captcha_confirmation.text != message
    fail(ArgumentError.new('Captcha Page Not Found'))
  end
end

def find_element_by_xpath(driver, xpath) 
  element = driver.find_element(:xpath => xpath)
end