FactoryBot.define do
    factory :instruction do
        step { Faker::Lorem.word}
    end
end