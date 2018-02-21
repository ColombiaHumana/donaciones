class AddEpaycoToDonators < ActiveRecord::Migration[5.1]
  def change
    add_column :donators, :x_ref_payco, :string
    add_column :donators, :x_transaction_id, :string
    add_column :donators, :x_signature, :string
    add_column :donators, :x_cod_response, :string
    add_column :donators, :x_approval_code, :string
  end
end
