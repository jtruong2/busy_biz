class Search < ApplicationRecord
    validates_presence_of :keyword
    validates_presence_of :location
end
