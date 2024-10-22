module Users
  class UpdateUser
    def initialize(user_id, user_params, user_repository = UserRepository.new)
      @user_id = user_id
      @user_params = user_params
      @user_repository = user_repository
    end

    def call
      user = @user_repository.find(@user_id)
      return { status: :not_found } unless user

      if @user_repository.update(user, @user_params)
        { status: :ok, user: user }
      else
        { status: :unprocessable_entity, errors: user.errors.full_messages }
      end
    end
  end
end
