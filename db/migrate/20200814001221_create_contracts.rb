class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.float :price, null: false
      t.datetime :validation, null: false
      t.datetime :expiration, null: false
      t.string :status, default: 'E', limit: 1
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
