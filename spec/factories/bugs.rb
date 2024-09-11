# spec/factories/bugs.rb
FactoryBot.define do
  factory :bug do
    title { Faker::Lorem.sentence }
    status { :started } # Use symbols for enum values
    bug_type { :bug } # Use symbols for enum values
    association :project
    association :user
    association :developer, factory: :user

    trait :with_screenshot do
      after(:build) do |bug|
        bug.screenshot.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_image.png')),
                              filename: 'test_image.png', content_type: 'image/png')
      end
    end
  end
end
