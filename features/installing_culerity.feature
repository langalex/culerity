Feature: Installing culerity
  In order to not have to use f@#$ing selenium and receive hate into our lives
  As a self-respective Rails/JavaScript developer
  I want to install culerity into my Rails app

  Scenario: Install culerity into a Rails app and check it works
    Given a Rails app
    And I run executable "script/generate" with arguments "cucumber"
    And I delete file "features/step_definitions/webrat_steps.rb"
    And I copy the project generators into "vendor/generators"
    And I invoke task "rake db:migrate"
    When I run executable "script/generate" with arguments "culerity"
    And I invoke task "rake cucumber:all"
    Then file "features/step_definitions/common_celerity_steps.rb" is created
    Then I should see "0 scenarios"
    Then I should see "0 steps"
  
  
  
