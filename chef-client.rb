# Depend on a specific version of sprinkle 
begin
  gem 'sprinkle', ">= 0.2.6" 
rescue Gem::LoadError
  puts "sprinkle 0.2.1 required.\n Run: `sudo gem install sprinkle`"
  exit
end

require 'erb'
require 'yaml'

$APP_CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), "config", "config.yml"))

host     = $APP_CONFIG['server']['host']
ip       = ARGV[0] || $APP_CONFIG['client']['ip']
user     = ARGV[1] || $APP_CONFIG['client']['user']
password = ARGV[2] || $APP_CONFIG['client']['password']

deploy_rb = ERB.new(File.read(File.join(File.dirname(__FILE__), 'config', 'deploy.rb.erb')), 0, "%<>")
content = deploy_rb.result(binding)
File.open(File.join(File.dirname(__FILE__), 'config', 'deploy.rb'),"w") { |file| file.write content }

# Require our receipes
%w(essentials ruby git rubygems chef).each do |r|
  require File.join(File.dirname(__FILE__), 'receipes', r)
end

# What we're installing to your server
# Take what you want, leave what you don't
# Build up your own and strip down your server until you get it right. 
policy :chef_client, :roles => :app do
  requires :ruby
  requires :rubygems
  requires :chef_client
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    begin
      recipes 'Capfile'
    rescue LoadError
      recipes 'deploy'
    end
  end
 
  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end