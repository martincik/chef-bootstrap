# Chef-server, Chef-client, zero to hero in under five minutes
Scripts for [Sprinkle](http://github.com/crafterm/sprinkle/ "Sprinkle"), the provisioning tool

## How to get your sprinkle on:

* Get a brand spanking new slice / host (Ubuntu please)
* Create user 'deploy' with pass 'deploy', add it to the /etc/sudoers file
* cp config/config.yml.example to config/config.yml
* Set your server/client IP and credentials in config/config.yml

From your local system run:

    ./bin/chef-server
    ./bin/chef-client

After you've waited for everything to run, you should have a provisioned slice.

### Chef is not running!?

No superfluous configuration is included, these scripts focus purely on chef installation. 

### Wait, what does all this install?

* Git (Apt)
* Ruby
* RubyGems (1.3.5)
* GEMS: ohio, chef, chef-server (and all dependencies)

## Requirements
* Ruby
* Capistrano
* Sprinkle (github.com/crafterm/sprinkle)
* An Ubuntu based machine

## Disclaimer

Don't run this on a system that has already been deemed "in production", its not malicious, but there is a fair chance
that you'll ass something up monumentally. You have been warned.