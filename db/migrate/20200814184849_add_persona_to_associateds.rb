class AddPersonaToAssociateds < ActiveRecord::Migration[5.2]
  def change
    add_reference :associateds, :persona, foreign_key: true
  end
end
