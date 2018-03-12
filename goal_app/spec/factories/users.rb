FactoryBot.define do
  factory :user do
    username { Faker::RickAndMorty.character }
    password "password"
  end
end
