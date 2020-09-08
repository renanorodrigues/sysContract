class Contract < ApplicationRecord
    belongs_to :document, inverse_of: :contract
    belongs_to :persona, inverse_of: :contract
    has_many :comments, dependent: :destroy
    accepts_nested_attributes_for :comments

    validates_presence_of :document
    validates :status, length: {maximum: 1}
end
