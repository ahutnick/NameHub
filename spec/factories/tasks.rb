FactoryBot.define do
  factory :task do
    title { "MyString" }
    completed { false }
    project { nil }
  end
end
