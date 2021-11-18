FactoryBot.define do
    factory :ingredient do
        name {Faker::Lorem.word}
    end
end