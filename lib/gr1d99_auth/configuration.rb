module Gr1d99Auth
  class Configuration
    attr_accessor :jwt_key, :jwt_verify, :jwt_algorithm, :jwt_exp
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
