class CreateDonators < ActiveRecord::Migration[5.1]
  def change
    create_table :donators do |t|
      t.string :doctype
      t.string :document
      t.string :firstname
      t.string :lastname

      t.float :amount

      t.timestamps
    end
    add_attachment :donators, :rut_image
    add_attachment :donators, :doc_image
  end
end
