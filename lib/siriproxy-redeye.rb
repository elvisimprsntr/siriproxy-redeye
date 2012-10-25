require 'siri_objects'

class SiriProxy::Plugin::RedEye < SiriProxy::Plugin
  attr_accessor :reipl1
  attr_accessor :reipl2
  
  def initialize(config)
    self.reip1 = config["reip1"]
    self.reip2 = config["reip2"]
  end

# Under development
	
end
