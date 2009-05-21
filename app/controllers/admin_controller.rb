class AdminController < ApplicationController
  # before_filter :authorize, :except => [:login]
  # 
  # def index
  #   @links = Link.find(:all, :limit => 10, :order => "updated_at DESC")
  # end
  # 
  # def logout
  #   session[:password] = nil
  #   redirect_to :action => :index
  # end
  #   
  # private
  # def authorize
  #   session[:password] = params[:password] if params[:password]
  #   unless session[:password] == ADMIN_PASS
  #     redirect_to :action => :login
  #   end
  #   true
  # end

end