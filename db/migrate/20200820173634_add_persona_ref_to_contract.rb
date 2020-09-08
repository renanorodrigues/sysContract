class AddPersonaRefToContract < ActiveRecord::Migration[5.2]
  def change
    add_reference :contracts, :persona, foreign_key: true
  end
end
