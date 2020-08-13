module Helpers
    def encode_token(payload)
        JWT.encode(payload, ENV["jwt_secret"])
    end
end