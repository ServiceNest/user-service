module Users
  class UserRepository
    def create(params)
      User.create!(params)
    end

    def all
      User.all
    end

    def find(id)
      User.find_by(id: id)
    end

    def update(user, params)
      user.update(params)
    end

    def destroy(user)
      user.destroy!
    end
  end
end