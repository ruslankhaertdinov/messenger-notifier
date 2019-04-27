FactoryGirl.define do
  factory :provider do
  end

  trait :whats_app do
    slug :whats_app
    kind Provider.kinds[:whats_app]
  end

  trait :viber do
    slug :viber
    kind Provider.kinds[:viber]
  end

  trait :telegramm do
    slug :telegramm
    kind Provider.kinds[:telegramm]
  end
end
