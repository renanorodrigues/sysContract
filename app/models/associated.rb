class Associated < ApplicationRecord
    belongs_to :persona, inverse_of: :associateds
    belongs_to :document, inverse_of: :associateds

    validates_presence_of :persona, :document
end
