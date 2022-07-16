FactoryBot.define do
  factory :answer do
    association :author, factory: :user

    body { 'MyAnswerText' }
    question

    trait :invalid do
      body { nil }
    end
  end
end
