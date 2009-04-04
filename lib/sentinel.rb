require File.join(File.dirname(__FILE__), "sentinel", "controller")
require File.join(File.dirname(__FILE__), "sentinel", "sentinel")

ActionController::Base.send :include, Sentinel::Controller