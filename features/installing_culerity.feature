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
    Then file "features/step_definitions/common_celerity_steps.rb" is created
    Then file "config/environments/culerity_development.rb" is created
    Then file "config/environments/culerity_continuousintegration.rb" is created
    When I invoke task "rake cucumber:all"
    Then I should see "0 scenarios"
    And I should see "0 steps"
    
    When I add a feature file to test Rails' index.html default file
    When I invoke task "rake cucumber:all"
    Then I should see "1 scenarios"
    And I should see "4 steps"
