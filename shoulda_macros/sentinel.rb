module Sentinel
  module Shoulda
    
    def sentinel_context(options = {}, &block)
      context "When sentinel is set up to #{options.inspect}" do
        setup do
          options.keys.each do |key|
            @controller.sentinel.stubs(key).returns(options[key])
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
        setup do
          action = "action_#{Digest::MD5.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join)}"
          @controller.class.grants_access_to lambda { false }, :only => [action.to_sym], :denies_with => denied_name
          get action.to_sym
        end
        
        merge_block(&block)
      end
    end
    
    def should_grant_access_to(command)
      context "performing `#{command}`" do
        should "allow access" do
          @controller.class.expects(:access_granted)
          eval command
        end
      end
    end
    
    def should_deny_access_to(*args)
      options = args.extract_options!
      command = args.shift
      
      context "performing `#{command}`" do
        should "call the proper denied handler" do
          @controller.class.access_denied.expects(:[]).with(options[:with] || :default)
          eval command
        end
      end
    end
    
    def should_not_guard(command)
      context "performing `#{command}`" do
        should "not use guard with a sentinel" do
          @controller.class.expects(:access_granted).never
          @controller.class.expects(:access_denied).never
        end
      end
    end
  end
end

Test::Unit::TestCase.extend(Sentinel::Shoulda)