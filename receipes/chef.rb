package :chef_client do
  gem 'chef' do
    post :install, "chef-solo -c /tmp/solo.rb -j /tmp/chef.json -r /tmp/bootstrap-090909.tar.gz"
  end

  requires :ghost
  requires :ohai
  requires :chef_client_gem_dependencies
  requires :chef_client_solo_config
  requires :chef_client_chef_json
  requires :chef_solo_recepies
end

package :chef_server do
  push_text 'authorized_openid_identifiers ["myopenid.com"]', '/etc/chef/server.rb', :sudo => true

  requires :chef_server_bootstrap
end

package :chef_server_bootstrap do
  gem 'chef chef-server' do
    post :install, "chef-solo -c /tmp/solo.rb -j /tmp/chef.json -r /tmp/bootstrap-090909.tar.gz"
  end

  requires :ghost
  requires :ohai
  requires :chef_server_gem_dependencies
  requires :chef_server_solo_config
  requires :chef_server_chef_json
  requires :chef_solo_recepies
end

package :chef_server_solo_config do
  transfer 'config/server/solo.rb', '/tmp/solo.rb', :sudo => true

  verify 'solo.rb' do
    has_file '/tmp/solo.rb'
  end
end

package :chef_server_chef_json do
  transfer 'config/server/chef.json', '/tmp/chef.json', :sudo => true

  verify 'chef.json' do
    has_file '/tmp/chef.json'
  end
end

package :chef_client_solo_config do
  transfer 'config/client/solo.rb', '/tmp/solo.rb', :sudo => true

  verify 'solo.rb' do
    has_file '/tmp/solo.rb'
  end
end

package :chef_client_chef_json do
  transfer 'config/client/chef.json', '/tmp/chef.json', :sudo => true

  verify 'chef.json' do
    has_file '/tmp/chef.json'
  end
end

package :chef_solo_recepies do
  transfer 'config/bootstrap-090909.tar.gz', '/tmp/bootstrap-090909.tar.gz', :sudo => true

  verify 'bootstrap-090909.tar.gz' do
    has_file '/tmp/bootstrap-090909.tar.gz'
  end
end

package :ohai do
  gem 'ohai' do
    pre :install, 'gem source --add http://gems.opscode.com'
  end

  verify do
    ruby_can_load 'ohai'
  end
end

package :ghost do
  gem 'ghost' do
    post :install, "ghost add #{$APP_CONFIG['server']['host']} #{$APP_CONFIG['server']['ip']}"
  end

  verify do
    has_file '/usr/bin/ghost'
  end
end

package :chef_server_gem_dependencies do
  gem 'stompserver ferret merb-core merb-slices merb-haml merb-assets merb-helpers mongrel coderay'
end

package :chef_client_gem_dependencies do
  gem 'json extlib systemu ruby-openid erubis stomp'
end