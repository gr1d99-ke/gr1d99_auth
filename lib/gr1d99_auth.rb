require 'active_support'
require 'active_support/core_ext'

require "gr1d99_auth/version"
require "gr1d99_auth/jwt"
require "gr1d99_auth/jwt_config"

module Gr1d99Auth
  class Error < StandardError; end

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
