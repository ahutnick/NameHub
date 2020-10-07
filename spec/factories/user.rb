FactoryBot.define do
    factory :user do 
        name { Faker::Name.name }
        email { Faker::Internet.email }
        password { "fuzzbuzz33" }
        password_confirmation { "fuzzbuzz33" }
    end
end
