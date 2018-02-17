class CreateDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :donations do |t|
      t.string :epayco_ref
      t.string :doctype
      t.string :document
      t.string :name
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :country
      t.string :city
      t.string :address
      t.string :ip
      t.float :amount
      t.integer :transaction_id
      t.datetime :transaction_date
      t.integer :x_cod_response

      t.timestamps
    end
    add_index :donations, :epayco_ref
  end
end
