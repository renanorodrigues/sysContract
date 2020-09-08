class RemoveUserFromDocument < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:documents, :user, foreign_key: true)
  end
end
