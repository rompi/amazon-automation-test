Feature: Signin
  As a user, I can sign in to amazon web

@SI_001
Scenario: Ok
  Given I open amazon web signin page
  And I input email on signin sekix16019@htwern.com
  And I input password on signin tomasdummy
  Then I should see otp page <message> or captcha confirmation message <captcha_confirm_message>
  Examples:
    | message                                                                   | captcha_confirm_message                                                                                                           |
    | We will email you a One Time Password (OTP) to authenticate your request. | To better protect your account, please re-enter your password and then enter the characters as they are shown in the image below. |

@SI_002
Scenario: Incorrect password
  Given I open amazon web signin page
  And I input email on signin sekix16019@htwern.com
  And I input password on signin inipasswordsalah
  Then I should see password error message <error_message> or captcha confirmation message <captcha_confirm_message>
  Examples:
    | error_message               | captcha_confirm_message                                                                                                           |
    | Your password is incorrect  | To better protect your account, please re-enter your password and then enter the characters as they are shown in the image below. |

