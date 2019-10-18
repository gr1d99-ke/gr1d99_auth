module Gr1d99Auth
  class Configuration
    attr_accessor :jwt_key, :jwt_verify, :jwt_algorithm, :jwt_exp, :time_zone
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new

    if @configuration.time_zone.nil?
      @configuration.time_zone = Defaults::TIME_ZONE
    end

    Time.zone = @configuration.time_zone

    @configuration
  end

  def self.configure
    yield configuration
  end
end
