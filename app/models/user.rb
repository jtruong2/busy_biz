class User < ApplicationRecord
    has_secure_password
    has_many :user_searches
    has_many :searches, through: :user_searches
    validates_presence_of :username
    validates_uniqueness_of :username
end
