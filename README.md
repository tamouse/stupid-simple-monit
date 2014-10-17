# stupid_simple_monit.rb

A really stupidly simple process monitoring script.

**Don't use this if you have real process monitoring needs, such as [god][god] or [monit][monit]!**

The genesis of this was a project that included [sidekiq][sidekiq] where the `sidekiq` process was stopping for some reason, and `monit` was not catching the shutdown and respawning it, and offering no indication why. As a stop-gap, we hacked this little ditty up. One of us had a bit of free time, so we played Keith Richards and took the original hack and minimized it to it's essence.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stupid-simple-monit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stupid-simple-monit

## Configuration

Create a configuration file that contains the info needed to find the PID of your running process,
and a shell command to respawn the process:

``` yaml
pidfile: path/to/pidfile
start_script: "shell command to respawn your process"
```

## Usage

The command is pretty simple:

    $ stupid_simple_monit.rb [CONFIG_FILE]

If you omit `CONFIG_FILE` it defaults to `./config.yml`.

Ideally, put this into a `crontab` to run, say, every 5 or 10 minutes. (Again that caveat if you need something real, use `god` or `monit`.)

## Contributing

1. Fork it ( https://github.com/tamouse/stupid-simple-monit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


[god]: https://rubygems.org/gems/god "An easy to configure, easy to extend monitoring framework written in Ruby." 
[monit]: http://mmonit.com/monit/ "System monitoring and error recovery"
[sidekiq]: https://rubygems.org/gems/sidekiq "Simple, efficient background processing for Ruby"
