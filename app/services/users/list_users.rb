module Users
  class ListUsers
    def initialize(user_repository = UserRepository.new)
      @user_repository = user_repository
    end

    def call
      @user_repository.all
    end
  end
end
