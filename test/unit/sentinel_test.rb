require 'test_helper'

class SentinelTest < ActiveSupport::TestCase
  context "When assigning attributes" do
    setup do
      @sentinel = Sentinel::Sentinel
    end
    
    should "create attr_accessor's for each valid key" do
      sentinel = @sentinel.new(:user => {:name => "John", :active => true}, :forum => {:name => "My Forum"})
      assert_equal({:name => "John", :active => true}, sentinel.user)
      assert_equal({:name => "My Forum"}, sentinel.forum)
      
      sentinel.user = sentinel.forum = nil
      assert_nil sentinel.user
      assert_nil sentinel.forum
    end
    
    should "not create attr_accessors for methods that already exist" do
      sentinel = @sentinel.new(:class => "fake", :to_s => "one", :user => "real")
      assert_equal sentinel.user, "real"
      assert_equal sentinel.class, Sentinel::Sentinel
      assert_not_equal sentinel.to_s, "one"
    end
    
    should "reassign predefined attribute values if set" do
      @sentinel.attr_accessor_with_default :message, "simple message"
      assert_equal "simple message", @sentinel.new.message
      assert_equal "complex message", @sentinel.new(:message => "complex message").message
    end
  end
  
  context "When overriding attributes" do
    setup do
      @sentinel = Sentinel::Sentinel
    end
    
    should "only override for that specific instance" do
      sentinel = @sentinel.new(:user => "assigned", :forum => nil)
      assert_equal "assigned", sentinel.user
      assert_nil sentinel.forum
      assert_nil sentinel[:user => nil].user
      assert_equal "forum", sentinel[:forum => "forum"].forum
    end
    
    should "define an attr_accessor if the attribute doesn't exist" do
      sentinel = @sentinel.new
      assert_raise NoMethodError do
        sentinel.name
      end
      
      assert_equal "taken", sentinel[:name => "taken"].name
      assert_nil sentinel.name
    end
  end
end
