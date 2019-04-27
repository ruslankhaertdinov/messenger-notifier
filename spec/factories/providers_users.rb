FactoryGirl.define do
  factory :providers_user do
    provider
    user
    username { Faker::Internet.user_name }
  end
end
