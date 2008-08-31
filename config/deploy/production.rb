set :deploy_to, "/var/www/apps/#{application}"
set :domain, "bloat.me"

set :user, "bloat"

role :web, domain
role :app, domain
role :db,  domain, :primary => true


namespace :console do
  desc "connect to remote rails console"
  task :default do
    input = ''
    run "cd #{current_path} && script/console #{rails_env}" do |channel, stream, data|
      next if data.chomp == input.chomp || data.chomp == ''
      print data
      channel.send_data(input = $stdin.gets) if data =~ /^(>|\?)>/
    end
  end
end

task :link_shared_stuff do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{shared_path}/config/cookie_secret #{release_path}/config/cookie_secret"  
  run "mkdir -p #{release_path}/tmp"
end

after "deploy:symlink", "link_shared_stuff"
before "deploy:update_code", "deploy:git:pending"