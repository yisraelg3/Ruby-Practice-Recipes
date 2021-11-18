class Recipe < ApplicationRecord
    has_many :ingredients, dependent: :destroy
    has_many :instructions, dependent: :destroy

    validates_presence_of :name
end
