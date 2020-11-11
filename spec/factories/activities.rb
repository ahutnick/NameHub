FactoryBot.define do
  factory :activity do
    user factory: :user
    action { "update" }
    trackable factory: :project
  end
end
