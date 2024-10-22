module Users
  class DestroyUser
    def initialize(user_id, user_repository = UserRepository.new)
      @user_id = user_id
      @user_repository = user_repository
    end

    def call
      user = @user_repository.find(@user_id)
      return nil unless user
      user.destroy!
    end
  end
end
