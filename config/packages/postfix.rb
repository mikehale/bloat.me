package :postfix, :provides => :mailserver do
  description 'Postfix Mailserver'
  apt 'postfix' do
    #TODO ensure that we are configred to send mail only from localhost
    # post :install, ''
  end
end
