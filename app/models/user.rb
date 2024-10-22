class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: %w[admin client employee] }
  validates :name, presence: true
  validates :lastname, presence: true
  validates :phone, presence: true, format: { with: /\A\d{10,15}\z/, message: 'must be a valid phone' }
  validates :password, presence: true, length: { in: 8..128 }, if: -> { new_record? || !password.nil? }

  def admin?
    role == 'admin'
  end

  def client?
    role == 'client'
  end

  def employee?
    role == 'employee'
  end
end
