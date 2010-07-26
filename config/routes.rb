ActionController::Routing::Routes.draw do |map|
  map.connect '/projects/:id/support/:action', :controller => 'support'
end
