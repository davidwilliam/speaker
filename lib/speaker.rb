require "speaker/version"
require "speaker/base"
require "speaker/configuration"

module Speaker

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
  
  def self.new(params={})
    Base.new(params)
  end
   
end
