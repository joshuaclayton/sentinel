module Sentinel
  module Shoulda
    
    def sentinel_context(options = {}, &block)
      context "When sentinel is set up to #{options.inspect}" do
        setup do
          options.keys.each do |key|
            @controller.sentinel.class.any_instance.stubs(key).returns(options[key])
          end
          options.keys.each do |key|
            assert_equal options[key], @controller.sentinel.send(key)
          end
        end
        
        merge_block(&block)
      end
    end
    
    def denied_with(denied_name, &block)
      context "denied_with #{denied_name}" do
        without_before_filters do # this strips out any other preconditions so we can properly test the handler 
          setup do
            action = "action_#{Digest::MD5.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join)}"
            @controller.class.grants_access_to lambda { false }, :only => [action.to_sym], :denies_with => denied_name
            get action.to_sym
          end
        
          merge_block(&block)
        end
      end
    end
    
    def without_before_filters(&block)
      context "" do
        setup do
          @filter_chain = @controller.class.filter_chain
          @controller.class.write_inheritable_attribute("filter_chain", ActionController::Filters::FilterChain.new)
        end
        
        teardown do
          @controller.class.write_inheritable_attribute("filter_chain", @filter_chain)
        end
        
        merge_block(&block)
      end
    end
    
    def should_grant_access_to(command)
      context "performing `#{command}`" do
        should "allow access" do
          granted = @controller.class.read_inheritable_attribute(:access_granted)
          @controller.class.expects(:access_granted).at_least(1).returns(granted)
          eval command
        end
      end
    end
    
    def should_deny_access_to(*args)
      options = args.extract_options!
      command = args.shift
      
      context "performing `#{command}`" do
        should "call the proper denied handler" do
          denied_with = options[:with] || :default
          handler = @controller.class.read_inheritable_attribute(:access_denied)[denied_with]
          @controller.class.access_denied.expects(:[]).with(denied_with).returns(handler)
          eval command
        end
      end
    end
    
    def should_not_guard(command)
      context "performing `#{command}`" do
        setup do
          @controller.class.expects(:access_granted).never
          @controller.class.expects(:access_denied).never
          @controller.class_eval do
            def rescue_action(e) raise e end; # force the controller to reraise the exception error
          end
        end
        
        should "not use guard with a sentinel" do
          eval command
        end
      end
    end
    
  end
end

Test::Unit::TestCase.extend(Sentinel::Shoulda)