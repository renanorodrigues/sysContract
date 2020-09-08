class Comment < ApplicationRecord
    belongs_to :user, inverse_of: :comments
    belongs_to :contract, inverse_of: :comments

    validates_presence_of :contract, :user
end
