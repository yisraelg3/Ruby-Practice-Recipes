FactoryBot.define do
    factory :recipe do
        name {Faker::Lorem.word}
    end
end