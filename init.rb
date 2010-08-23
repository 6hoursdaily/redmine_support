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

class SupportViewer < Redmine::Hook::ViewListener
  def view_layouts_base_body_bottom(context = { })
    if context[:controller].class.name == 'IssuesController'
      image = image_tag("#{ActionController::Base.relative_url_root}/images/help.png", :style => 'margin-bottom: -0.3em;').gsub('"', '\"')
      
      # TODO: make this html a plugin setting
      return "
<script type=\"text/javascript\">
  var elems = $$('#content h2')
  if ((elems != null) && (elems.length > 0))
    elems[0].insert({after: \"<p>#{image} New users cannot create issues. Please see the <a href=\\\"../tabs/support\\\">support</a> page for more info.</p>\"})
</script>
"
    end
  end
end
