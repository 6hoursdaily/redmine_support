require 'redmine'

Redmine::Plugin.register :redmine_support do

  name 'Redmine Support plugin'
  author 'Nick Bolton'
  description 'Allows users to create simple support tickets.'
  version '0.0.1'
  
  project_module :support do
    permission :new_support_ticket, :support => :new
  end
  
end
