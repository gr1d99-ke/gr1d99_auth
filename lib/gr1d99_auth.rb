require 'active_support'
require 'active_support/core_ext'

require "gr1d99_auth/version"
require "gr1d99_auth/configuration"
require "gr1d99_auth/jwt"
require "gr1d99_auth/defaults"

module Gr1d99Auth
  class Error < StandardError; end
end
