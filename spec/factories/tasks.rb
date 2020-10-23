FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    project factory: :project
    stage { "idea" }
  end
end
