FactoryGirl.define do
  factory :user_message do
    username { "@#{ Faker::Internet.user_name }" }
  end
end
