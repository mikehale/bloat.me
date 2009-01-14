Capistrano::Configuration.instance.load do
  set :monit, "/usr/local/bin/monit"
  set :actions, %w(start stop restart)

  namespace :deploy do
    namespace :web do
      actions.each {|action|
        desc "#{action} the webserver"
        task action.to_sym do
          run "sudo #{monit} #{action} all -g www"
        end
      }
    end
  end
end