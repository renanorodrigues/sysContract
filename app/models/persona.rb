class Persona < ApplicationRecord
    has_many :associateds
    has_many :documents, through: :associateds
    has_one :contract
end
