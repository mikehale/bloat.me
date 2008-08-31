Capistrano::Configuration.instance.load do
  namespace :log do    
    set :domain, nil    
    
    namespace :rails do
      desc "tail rails #{rails_env} log file" 
      task :tail, :roles => :app do
        tail_file "#{shared_path}/log/#{rails_env}.log"
      end
    end
    
    namespace :www do
      %w(access error rewrite).each {|log|
        desc "tail app's www #{log} log"
        task "tail_#{log}".to_sym, :roles => :app do
          tail_file "#{shared_path}/log/#{log}"
        end
      }
    end
    
    def tail_file(file, via=:run)
      # how to exit cleanly so that we don't get a stack trace?
      invoke_command("tail -f #{file}", {:via => via}) do |channel, stream, data|
        puts  # for an extra line break before the host name
        puts "#{channel[:host]}: #{data}" 
        break if stream == :err
      end
    end    
  end
  
  namespace :console do
    desc "connect to remote rails console"
    task :default do
      input = ''
      run "cd #{current_path} && ./script/console #{rails_env}" do |channel, stream, data|
        next if data.chomp == input.chomp || data.chomp == ''
        print data
        channel.send_data(input = $stdin.gets) if data =~ /^(>|\?)>/
      end
    end
  end
  
end
