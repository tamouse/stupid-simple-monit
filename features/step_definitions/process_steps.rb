Given(/^a running process with a valid PID$/) do
  @pid = Process.spawn("sleep 10000000")
end

Given(/^a valid pid file$/) do
  step(%Q{a file named "pidfile" with:},"#{@pid}\n")
end

Then(/^the running process should be shut down$/) do
  Process.kill "TERM", @pid
  Process.wait @pid
end

