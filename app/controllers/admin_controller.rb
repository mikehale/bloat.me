class AdminController < ApplicationController
  before_filter :authorize, :except => [:login]
  skip_before_filter :verify_authenticity_token
  
  def logout
    session[:password] = nil
  end
    
  private
  def authorize
    session[:password] = params[:password]
    unless session[:password] == ADMIN_PASS
      redirect_to :action => :login
    end
    true
  end

end