class ForumsController < ApplicationController
  controls_access_with do
    ForumSentinel.new :current_user => current_user, :forum => @forum
  end
  
  grants_access_to lambda { stubbed_method }, :denies_with => :redirect_to_index
  
  grants_access_to :denies_with => :sentinel_unauthorized do
    stubbed_method_two
  end
  
  grants_access_to :reorderable?, :only => [:reorder]
  grants_access_to :creatable?, :only => [:new, :create], :denies_with => :redirect_to_index
  grants_access_to :viewable?, :only => [:show], :denies_with => :sentinel_unauthorized
  grants_access_to :destroyable?, :only => [:destroy]
  
  on_denied_with :redirect_to_index do
    redirect_to url_for(:controller => "forums", :action => "secondary_index")
  end
  
  on_denied_with :sentinel_unauthorized do
    respond_to do |wants|
      wants.html { render :text => "This is an even more unique default restricted warning", :status => :forbidden }
      wants.any { head :forbidden }
    end
  end
  
  def index
    handle_successfully
  end
  
  def secondary_index
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
  
  def stubbed_method
    true
  end
  
  def stubbed_method_two
    true
  end
end