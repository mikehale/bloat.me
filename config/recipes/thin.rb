Capistrano::Configuration.instance.load do
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
      desc "#{action} the appserver(s)"
      task action.to_sym do 
        thin.send action 
      end
    end
  end
end