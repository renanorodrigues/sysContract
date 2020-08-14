class Contract < ApplicationRecord
    belongs_to :document
    has_many :comments, dependent: :destroy
end
