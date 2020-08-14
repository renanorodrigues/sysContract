class Persona < ApplicationRecord
    has_many :associateds
    has_many :documents, through: :associateds
end
