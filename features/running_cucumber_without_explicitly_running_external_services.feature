Feature: Running cucumber without explicitly running external services
  In order to reduce learning cost of using culerity
  As a rails developer
  I want the headless browser and rails processes to launch and shutdown automatically

  Background:
    Given a Rails app
    And I run executable "script/generate" with arguments "cucumber"
    And I delete file "features/step_definitions/webrat_steps.rb"
    And I copy the project generators into "vendor/generators"
    And I invoke task "rake db:migrate"
    When I run executable "script/generate" with arguments "culerity"
    And I setup load path to local code
  
  Scenario: Successfully run scenarios without requiring celerity or rails processes running
    When I add a feature file to test Rails index.html default file
    And I run executable "cucumber" with arguments "features/"
    Then file "tmp/culerity_rails_server.pid" is not created
    And I should see "1 scenario"
    And I should see "5 steps (5 passed)"
    And I should see "WARNING: Speed up execution by running 'rake culerity:rails:start'"
  
  
  
