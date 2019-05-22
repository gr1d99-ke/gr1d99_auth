module Gr1d99Auth
  module ErrorHandler
    begin
    rescue ::JWT::DecodeError
      invalid_jwt
    end
  end
end
