module Users
  class ShowUser
    def initialize(user_id, user_repository = UserRepository.new)
      @user_id = user_id
      @user_repository = user_repository
    end

    def call
      @user_repository.find(@user_id)
    end
  end
end
