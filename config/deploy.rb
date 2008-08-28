set :default_stage, "production"

require 'capistrano/ext/multistage'
require 'spacesuit/recipes/multistage_patch'
require 'spacesuit/recipes/common'

set :application, "bloat"
set :rails_env, "production"
set :ssh_options, {:forward_agent => true}
set :use_sudo, false

default_run_options[:pty] = true
set :scm, "git"
set :branch, "master"
set :repository,  "git@github.com:kohlhofer/rubyurl.git"
set :deploy_via, :remote_cache
set :keep_releases, 30
set :git_enable_submodules, 1

namespace :thin do
  %w{start stop restart}.each {|action|
    desc "#{action} thin"
    task action.to_sym do
      run "sudo thin #{action} --config /etc/thin/#{application}.yml"
    end
  }
end

namespace :deploy do
  %w(start stop restart).each do |action|
    task action.to_sym do 
      thin.send action 
    end
  end
end