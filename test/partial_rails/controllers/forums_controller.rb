class ForumsController < ApplicationController
  controls_access_with do
    ForumSentinel.new :current_user => current_user, :forum => @forum
  end
  
  grants_access_to :reorderable?, :only => [:reorder]
  grants_access_to :creatable?, :only => [:new, :create]
  grants_access_to :viewable?, :only => [:show]
  grants_access_to :destroyable?, :only => [:destroy]
  
  with_access do
    true
  end
  
  on_denied_with :unauthorized do
    respond_to do |wants|
      wants.html { render :text => "This is an even more unique default restricted warning", :status => :unauthorized }
      wants.any { head :unauthorized }
    end
  end
  
  
  def index
    handle_successfully
  end
  
  def new
    handle_successfully
  end
  
  def show
    handle_successfully
  end
  
  def edit
    handle_successfully
  end
  
  def update
    handle_successfully
  end
  
  def delete
    handle_successfully
  end
  
  private
  
  def handle_successfully
    render :text => "forums"
  end
end