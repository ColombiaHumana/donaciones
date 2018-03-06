class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :donators
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
end
