class AddJobToDonator < ActiveRecord::Migration[5.1]
  def change
    add_column :donators, :job, :string
  end
end
