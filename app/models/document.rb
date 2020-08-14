class Document < ApplicationRecord
    belongs_to :user
    has_one :contract
    has_one_attached :file

    accepts_nested_attributes_for :contract
end
