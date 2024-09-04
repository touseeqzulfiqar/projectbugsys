FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    description { 'A description of the project' }
    association :creator, factory: :user

    after(:create) do |project|
      create_list(:user, 2, projects: [project])
    end
  end
end
