Feature: Stupid, simple process monitor
  In order to keep a process alive
  As a system monitor
  I want check that a process is running and respawn it if it isn't


  Scenario: no config file exists
    # Given a file "config.yml" does not exist
    When I run `stupid_simple_monit.rb`
    Then the output should match /No such file or directory.*config.yml/
    And the exit status should be 1

  Scenario: empty config file exists
    Given an empty file named "config.yml"
    When I run `stupid_simple_monit.rb`
    Then the exit status should be 1
    And the stderr should contain "config file empty"

  Scenario: a config file that isn't yaml
    Given a file named "config.yml" with:
    """
    this is not YAML
    """
    When I run `stupid_simple_monit.rb`
    Then the exit status should be 1
    And the stderr should contain "config file empty"
  
  Scenario: a config file with missing PID file
    Given a file named "config.yml" with:
    """
    pidfile: bogus
    start_script: echo I ran
    """
    When I run `stupid_simple_monit.rb`
    Then the exit status should be 0
    And the output should contain "I ran"

  Scenario: a config file with a bogus start_script
    Given a file named "config.yml" with:
    """
    pidfile: bogus
    start_script: this_is_a_bogus_shell_command
    """
    When I run `stupid_simple_monit.rb`
    Then the exit status should be 1
    And the output should contain "respawn failed"
  
  Scenario: a config file with valid PID file and a running process
    Given a running process with a valid PID
    And a valid pid file
    And a file named "config.yml" with:
    """
    pidfile: pidfile
    start_script: echo I ran
    """
    When I run `stupid_simple_monit.rb`
    Then the exit status should be 0
    And the output should not contain "I ran"
    And the running process should be shut down
  
  Scenario: a config file with valid PID file and a stopped process
    Given a running process with a valid PID
    And a valid pid file
    And a file named "config.yml" with:
    """
    pidfile: pidfile
    start_script: echo I ran
    """
    And the running process should be shut down
    When I run `stupid_simple_monit.rb`
    Then the exit status should be 0
    And the output should contain "I ran"
  
  Scenario: pass a config file on the command line
    Given a file named "my_ssm_config.yml" with:
    """
    pidfile: bogus
    start_script: echo I ran
    """
    When I run `stupid_simple_monit.rb my_ssm_config.yml`
    Then the exit status should be 0
    And the output should contain "I ran"

  Scenario: pass a non-existing config file on the command line
    When I run `stupid_simple_monit.rb no_config_file`
    Then the exit status should be 1
    And the output should match /No such file or directory.*no_config_file/

