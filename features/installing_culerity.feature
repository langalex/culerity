Feature: Installing culerity
  In order to not have to use f@#$ing selenium and receive hate into our lives
  As a self-respective Rails/JavaScript developer
  I want to install culerity into my Rails app

  Background:
    Given a Rails app
    And I run executable "script/generate" with arguments "cucumber"
    And I delete file "features/step_definitions/webrat_steps.rb"
    And I copy the project generators into "vendor/generators"
    And I invoke task "rake db:migrate"
    When I run executable "script/generate" with arguments "culerity"
    And I setup load path to local code
  
  Scenario: Install culerity and setup jruby environment
    Given I have jruby installed
    When I invoke task "rake culerity:install"
    Then the gem "jarib-celerity" is installed into jruby environment

  Scenario: Install culerity and test the rails start + stop tasks
    When I invoke task "rake culerity:rails:start"
    Then file "tmp/culerity_rails_server.pid" is created
    And I invoke task "rake culerity:rails:stop"
    Then file "tmp/culerity_rails_server.pid" is not created

  Scenario: Install culerity into a Rails app and check it works
    Then file "features/step_definitions/common_celerity_steps.rb" is created
    Then file "config/environments/culerity_development.rb" is created
    Then file "config/environments/culerity_continuousintegration.rb" is created
    
    And I run executable "cucumber" with arguments "features/"
    Then I should see "0 scenarios"
    And I should see "0 steps"
    
    Given I invoke task "rake culerity:rails:start"
    
    When I add a feature file to test Rails index.html default file
    And I run executable "cucumber" with arguments "features/"
    Then I should see "1 scenario"
    And I should see "5 steps (5 passed)"
    And I should not see "WARNING: Speed up executing by running 'rake culerity:rails:start'"

  
  
  
  