module Gr1d99Auth
  class JWTConfig
    attr_reader :key, :verify, :algorithm, :exp

    def initialize(config_opts)
      @key = config_opts.fetch(:key)
      @verify = config_opts.fetch(:verify)
      @algorithm = config_opts.fetch(:algorithm)
      @exp = config_opts.fetch(:exp)
    end
  end
end
