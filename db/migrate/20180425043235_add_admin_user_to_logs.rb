class AddAdminUserToLogs < ActiveRecord::Migration[5.1]
  def change
    add_reference :logs, :admin_user, foreign_key: true
    add_reference :logs, :donator, foreign_key: true
  end
end
