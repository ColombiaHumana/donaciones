class AddRejectedToDonator < ActiveRecord::Migration[5.1]
  def change
    add_column :donators, :rejected, :boolean, default: false
    add_reference :donators, :admin_user, foreign_key: true
  end
end
