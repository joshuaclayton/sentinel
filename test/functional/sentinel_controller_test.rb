require 'test_helper'

class SentinelControllerTest < ActionController::TestCase
  def setup
    @controller = ForumsController.new
  end
  
  context "on GET to :index" do
    setup do
      get :index
    end
    
    should_respond_with :success
  end
end