module Helpers
    def get_user_by_username(username)
        User.find_by(username: username)
    end
end