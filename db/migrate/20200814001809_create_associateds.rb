class CreateAssociateds < ActiveRecord::Migration[5.2]
  def change
    create_table :associateds do |t|
      t.references :document, foreign_key: true
      t.references :persona, foreign_key: true

      t.timestamps
    end
  end
end
