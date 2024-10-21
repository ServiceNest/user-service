class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[admin client employee] }
end
