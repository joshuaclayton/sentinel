module Sentinel
  class Sentinel
    def initialize(*args)
      attributes = args.extract_options!
      attributes.keys.each do |key|
        create_accessor_for_attribute(key)
        self.send("#{key}=", attributes[key]) if self.respond_to?("#{key}=")
      end
    end
    
    def [](temporary_overrides)
      temporary_overrides.keys.each do |key|
        create_accessor_for_attribute(key)
      end
      
      returning self.clone do |duplicate|
        temporary_overrides.keys.each do |key|
          duplicate.send("#{key}=", temporary_overrides[key]) if self.respond_to?("#{key}=")
        end
      end
    end
    
    private
    
    def create_accessor_for_attribute(attribute)
      self.class_eval { attr_accessor attribute } unless self.respond_to?(attribute) || self.respond_to?("#{attribute}=")
    end
  end
end