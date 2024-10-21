FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "jhon.doe@mail.com" }
    password { "password" }
    role { "client" }
  end
end