class Search < ApplicationRecord
    validates :criteria, uniqueness: true
end
