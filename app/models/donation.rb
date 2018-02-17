class Donation < ApplicationRecord
  validates_presence_of :epayco_ref,:doctype,:document,:name,:lastname,:email,:phone,
            :country,:city,:address,:ip,:amount,:transaction_id,
            :transaction_date,:x_cod_response
  validates_uniqueness_of :epayco_ref
end
