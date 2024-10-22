FactoryBot.define do
  factory :user do
    name { "John" }
    email { "jhon.doe@mail.com" }
    password { "password" }
    role { "client" }
    lastname { "Doe" }
    phone { "1234567890" }
  end
end