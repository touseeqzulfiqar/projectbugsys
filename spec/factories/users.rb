FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    role { :developer }

    trait :manager do
      role { :manager }
    end

    trait :QA do
      role { :QA }
    end
  end
end
