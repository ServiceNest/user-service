module Users
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :role, :name, :lastname, :phone, :created_at
  end
end