require "jwt"
require "gr1d99_auth/jwt_config"

module Gr1d99Auth
  class JWT
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def self.encode(payload, config = JWTConfig.new({}))
      new(config).encode(payload)
    end

    def self.decode(token, config = JWTConfig.new({}))
      new(config).decode(token)
    end

    def encode(payload)
      payload[:exp] = config.exp unless config.exp.nil?
      key = config.key
      algorithm = config.algorithm
      ::JWT.encode(payload, key, algorithm)
    end

    def decode(token)
      key = config.key
      verify = config.verify
      opts = { algorithm: config.algorithm }
      ::JWT.decode(token, key, verify, opts)
    end
  end
end
