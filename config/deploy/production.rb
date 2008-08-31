set :deploy_to, "/var/www/apps/#{application}"
set :domain, "bloat.me"

set :user, "bloat"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

task :link_shared_stuff do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  run "ln -nfs #{shared_path}/config/cookie_secret #{release_path}/config/cookie_secret"  
  run "mkdir -p #{release_path}/tmp"
end

after "deploy:symlink", "link_shared_stuff"
before "deploy:update_code", "deploy:git:pending"