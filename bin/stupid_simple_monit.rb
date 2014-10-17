require 'yaml'

def process_exists?(pid)
  begin
    Process.kill 0, pid
    return true
  rescue
    return false
  end
end

config = YAML.load(File.read('config.yml'))
pidfile = config['pidfile']

respawn = true

if File.exist?(pidfile)
  pid = File.read(pidfile)

  if pid == ''
    puts "#{pidfile} is empty"
  else
    pid = pid.to_i
    if process_exists?(pid)
      puts 'process exists'
      respawn = false
    else
      puts "process #{pid} doesn't exist"
    end
  end
else
  puts "#{pidfile} not found"
end

if respawn
  puts 'respawning'
  system config['start_script']
end
