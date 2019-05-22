module Gr1d99Auth
  module Helpers
    p ancestors

    def generate_token(user_id)
      payload = { "user_id" => user_id }
      JWT.encode(payload)
    end

    def authenticate
      jwt_missing and return unless jwt_token

      payload_data = JWT.decode(jwt_token)[0]
      user_id      = payload_data["user_id"]
      user         = User.find_by(id: user_id)
      instance_variable_set(:"@current_user", user)
    end

    def authorization_header
      request.env["HTTP_AUTHORIZATION"]
    end

    def jwt_token
      return nil unless authorization_header

      authorization_header.split(" ")[1]
    end

    def jwt_missing
      handle_jwt_missing
    end

    def handle_jwt_missing
      yield
    end

    def invalid_jwt
      yield
    end
  end
end
