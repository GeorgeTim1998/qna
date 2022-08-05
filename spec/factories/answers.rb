FactoryBot.define do
  factory :answer do
    association :author, factory: :user

    body { 'MyAnswerText' }
    question

    trait :invalid do
      body { nil }
    end

    factory :answer_with_votes do
      transient do
        votes_count { 3 }
      end

      after(:create) do |answer, evaluator|
        create_list(:vote, evaluator.votes_count, :for_answer, votable: answer)
        answer.reload
      end
    end
  end
end
