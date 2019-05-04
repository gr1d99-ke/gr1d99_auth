require "jwt"

module Gr1d99Auth
  class JWT
    attr_reader :config

    def initialize
      @config = Gr1d99Auth.configuration
    end

    def self.encode(payload)
      new.encode(payload)
    end

    def self.decode(token)
      new.decode(token)
    end

    def encode(payload)
      payload[:exp] = config.jwt_exp unless config.jwt_exp.nil?
      key = config.jwt_key
      algorithm = config.jwt_algorithm
      ::JWT.encode(payload, key, algorithm)
    end

    def decode(token)
      key = config.jwt_key
      verify = config.jwt_verify
      opts = { algorithm: config.jwt_algorithm }
      ::JWT.decode(token, key, verify, opts)
    end
  end
end
