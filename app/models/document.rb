class Document < ApplicationRecord
    has_one :contract, dependent: :destroy
    has_many :permissions
    has_many :associateds, dependent: :destroy
    has_many :personas, through: :associateds
    has_one_attached :file

    accepts_nested_attributes_for :contract, reject_if: proc { |attributes| attributes['price'].blank? }
    accepts_nested_attributes_for :associateds
    accepts_nested_attributes_for :permissions

    validates :file, presence: true
end
