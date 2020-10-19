FactoryBot.define do
  factory :project do
    title { Faker::Book.title }
    description { Faker::Lorem.sentences(number: 1) }
    user factory: :user
  end
end
