class Screen < ApplicationRecord

    belongs_to :theater
    has_many :shows

    validates :name , presence: true
    validates :theater , presence: true
end


