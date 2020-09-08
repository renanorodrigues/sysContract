class AddVisibilityToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :visibility_mode, :string, default: 'G', limit: 1
  end
end
