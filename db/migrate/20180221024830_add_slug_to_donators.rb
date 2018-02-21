class AddSlugToDonators < ActiveRecord::Migration[5.1]
  def change
    add_column :donators, :slug, :string
    add_index :donators, :slug, unique: true
  end
end
