class CreatePersonas < ActiveRecord::Migration[5.2]
  def change
    create_table :personas do |t|
      t.string :full_name
      t.string :observation
      t.string :identification
      t.string :email

      t.timestamps
    end
  end
end
