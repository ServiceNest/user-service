module Users
  class CreateUser
    def initialize(user_params, user_repository = UserRepository.new)
      @user_params = user_params
      @user_repository = user_repository
    end

    def call
      @user_repository.create(@user_params)
    end
  end
end