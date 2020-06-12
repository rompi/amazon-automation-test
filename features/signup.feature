Feature: Signup
  As a user, I can sign up to amazon web

@SU_001
Scenario: Ok
  Given I open amazon web signup page
  And I input name on signup <name>
  And I input email on signup <email>
  And I input password on signup <password>
  And I input password confirmation on signup <password>
  Then I see verify email page on signup <verify_message> <email> or signup captcha validation <captcha_validation_message>
  Examples:
    | name | email            | password    | verify_message                                                | captcha_validation_message                               |
    | Agus | agus1@amazon.com | password123 | To verify your email, we've sent a One Time Password (OTP) to | Please solve this puzzle so we know you're a real person |

@SU_002
Scenario: Invalid email
  Given I open amazon web signup page
  And I input name on signup <name>
  And I input email on signup <email>
  And I input password on signup <password>
  And I input password confirmation on signup <password>
  Then I see invalid email error message on signup <error_message>
  Examples:
    | name | email     | password    | error_message |
    | Agus | agusdoank | password123 | Enter a valid email address |