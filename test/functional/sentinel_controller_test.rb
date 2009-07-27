require 'test_helper'

class SentinelControllerTest < ActionController::TestCase
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper

  def setup
    @controller = ForumsController.new
  end

  sentinel_context do
    without_before_filters do
      should_not_guard "get :index"
    end
  end

  sentinel_context({:viewable? => true}) do
    should_grant_access_to "get :show"
  end

  sentinel_context({:creatable? => false}) do
    should_deny_access_to "get :new",
                          "post :create, :forum => {:name => 'My New Forum'}",
                          :with => :redirect_to_index
  end

  sentinel_context({:creatable? => true}) do
    should_grant_access_to  "get :new",
                            "post :create, :forum => {:name => 'My New Forum'}"
  end

  sentinel_context({:viewable? => false}) do
    should_deny_access_to "get :show", :with => :sentinel_unauthorized
  end

  context "A controller-global grants_access_to that denies access" do
    # this ensures that, even with a failing grants_access_to,
    # we can properly test all denied_with handlers
    setup do
      @controller.stubs(:stubbed_method).returns(false)
    end

    denied_with :redirect_to_index do
      should_redirect_to("forums root") do
        url_for(:controller => "forums", :action => "secondary_index")
      end
    end

    denied_with :sentinel_unauthorized do
      should_respond_with :forbidden

      should "render text as response" do
        assert_equal  "This is an even more unique default restricted warning",
                      @response.body
      end
    end
  end
end
