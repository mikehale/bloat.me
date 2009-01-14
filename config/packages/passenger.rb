package :passenger, :provides => :appserver do
  description 'Phusion Passenger (mod_rails)'
  version = '2.0.6'

  gems_path = '/usr/local/lib/ruby/gems'
  ruby_path = '/usr/local/bin/ruby'
  passenger_load_path = '/etc/apache2/mods-available/passenger.load'
  passenger_conf_path = '/etc/apache2/mods-available/passenger.conf'
  mod_passenger_path = "#{gems_path}/1.8/gems/passenger-#{version}/ext/apache2/mod_passenger.so"

  gem 'passenger' do
    post :install, 'echo -en "\n\n\n\n" | passenger-install-apache2-module'

    post :install, %(echo 'LoadModule passenger_module #{mod_passenger_path}' > #{passenger_load_path})

    post :install, %(echo 'PassengerRoot #{gems_path}/1.8/gems/passenger-#{version}' > #{passenger_conf_path})
    post :install, %(echo 'PassengerRuby #{ruby_path}' >> #{passenger_conf_path})

    post :install, 'a2enmod passenger'
    post :install, '/usr/sbin/apache2ctl configtest && /usr/sbin/apache2ctl graceful'
  end

  verify do
    has_file mod_passenger_path
    has_file passenger_load_path
    has_file passenger_conf_path
    has_file passenger_load_path.gsub('available', 'enabled')
    has_file passenger_conf_path.gsub('available', 'enabled')
  end

  requires :apache
  requires :apache2_prefork_dev
  requires :build_essential
  requires :ruby_enterprise_edition # I'd like to require :ruby1_8_6
end