class AddFieldToDonators < ActiveRecord::Migration[5.1]
  def change
    add_column :donators, :mobilephone, :string
    add_column :donators, :address, :string
    add_column :donators, :status, :string, default: "PRE"
    add_column :donators, :payed, :boolean, default: false
    add_column :donators, :email, :string
  end
end
