class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery
  
  before_filter :calculate_links
  
  # refactor to some sort of cache tool
  def calculate_links
    @cached_data = {:link_count => Link.count}
  end
end
