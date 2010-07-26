class SupportController < ApplicationController
  unloadable
  
  before_filter :find_project, :only => :new
  before_filter :authorize

  def new
    @issue = Issue.new
    @issue.project = @project
    @issue.tracker = find_tracker
    @issue.author = User.current

    # copy the form data from the form to the issue
    if params[:issue].is_a?(Hash)
      @issue.attributes = params[:issue]
    end
    
    if request.post?
      if @issue.save
        # redirect to the issue page so the user can see their ticket
        flash[:notice] = "Support ticket created."
        redirect_to(:controller => 'issues', :action => 'show', :id => @issue)
        return
      else
        flash[:error] = "Could not create support ticket."
      end
    end
  end

  def find_tracker
    # always use whatever tracker is named 'Support' - should be ok
    # to hard code since this is the support module after all.
    @project.trackers.find(:first, :conditions => { :name => 'Support' })
  end

  def find_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
