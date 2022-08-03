FactoryBot.define do
  factory :achievement do
    name { 'AchievmentFactory' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('storage/price.jpg')) }
    question
    association :winner, factory: :user
  end
end
