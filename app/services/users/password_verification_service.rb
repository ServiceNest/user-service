# frozen_string_literal: true

module Users
  class PasswordVerificationService
    def initialize(user_repository: Users::UserRepository.new)
      @user_repository = user_repository
    end

    def verify(email, password)
      user = @user_repository.find_by_email(email)

      return { success: false, error: 'User not found' } if user.nil?
      return { success: false, error: 'Invalid password' } unless user.authenticate(password)

      { success: true, user: user }

    rescue StandardError => e
      Rails.logger.error("Password verification failed: #{e.message}")
      { success: false, error: 'Internal server error' }
    end
  end
end
