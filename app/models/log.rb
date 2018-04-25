class Log < ApplicationRecord
  belongs_to :admin_user
  belongs_to :donator
end
