require 'config/recipes/logs_console'

set :deploy_to, "/var/www/apps/#{application}"
set :domain, "bloat.me"
set :user, "bloat"

role :web, domain
role :app, domain, :primary => true
role :db,  domain, :primary => true

namespace :deploy do
 desc "Create asset packages for production" 
 task :after_update_code, :roles => [:web] do
   run "cd #{release_path} && rake RAILS_ENV=production asset:packager:build_all"
 end
end

task :link_shared_stuff do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{shared_path}/config/cookie_secret #{release_path}/config/cookie_secret"  
  run "mkdir -p #{release_path}/tmp"
end

after "deploy:symlink", "link_shared_stuff"
before "deploy:update_code", "deploy:git:pending"

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
