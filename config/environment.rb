RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.frameworks -= [ :action_web_service, :action_mailer ]

  config.action_controller.session = { 
    :session_key => "_bloatme_session", 
    :secret => (RAILS_ENV == 'production') ? File.read(File.join(File.dirname(__FILE__), 'cookie_secret')) : 'oy8j2c45ync4ny43n3cmtho3cht35y4t8hn7'
  }
end
