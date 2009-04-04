require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'

require 'action_controller'
require 'action_controller/test_case'

require File.join(File.dirname(__FILE__), "../rails/init")

require File.join(File.dirname(__FILE__), "partial_rails", "controllers", "application_controller")
require File.join(File.dirname(__FILE__), "partial_rails", "controllers", "forums_controller")
require File.join(File.dirname(__FILE__), "partial_rails", "forum_sentinel")
require File.join(File.dirname(__FILE__), "..", "shoulda_macros", "sentinel")

require 'redgreen'
require 'shoulda/rails'

ActionController::Routing::Routes.clear!
ActionController::Routing::Routes.draw {|m| m.connect ':controller/:action/:id' }
ActionController::Routing.use_controllers! "forums"