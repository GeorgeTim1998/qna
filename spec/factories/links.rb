FactoryBot.define do
  factory :link do
    name { 'Google' }
    url { 'https://google.com' }

    trait :for_question do
      association :linkable, factory: :question
    end
  end
end
