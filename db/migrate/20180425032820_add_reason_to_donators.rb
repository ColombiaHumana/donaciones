class AddReasonToDonators < ActiveRecord::Migration[5.1]
  def change
    add_column :donators, :reason, :string
  end
end
