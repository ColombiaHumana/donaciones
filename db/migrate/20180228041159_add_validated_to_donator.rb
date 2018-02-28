class AddValidatedToDonator < ActiveRecord::Migration[5.1]
  def change
    add_column :donators, :validated, :boolean, default: false
  end
end
