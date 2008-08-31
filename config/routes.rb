ActionController::Routing::Routes.draw do |map|
  map.connect 'remote', :controller => 'links', :action => 'create'  
  map.connect 'about', :controller => 'links', :action => 'about'
  map.connect 'report-abuse', :controller => 'links', :action => 'report'
  map.connect 'home', :controller => 'links', :action => 'home'  
  map.root :controller => 'links', :action => 'home'
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
  
  map.connect ':token', :controller => 'links', :action => 'redirect'  
end
