FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence }
    task factory: :task
  end
end
