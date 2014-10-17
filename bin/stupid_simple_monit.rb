#!/usr/bin/env ruby
require 'yaml'

def config
  @_config ||= YAML.load_file(ARGV[0] || 'config.yml').tap{|t| fail "config file empty" unless t.is_a?(Hash)}
end

def process_exists?
  !!Process.kill(0, Integer(File.read(config.fetch('pidfile')))) rescue false
end

exit if process_exists?
fail 'respawn failed' unless system(config.fetch('start_script'))
