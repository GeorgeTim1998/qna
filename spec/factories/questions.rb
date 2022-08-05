FactoryBot.define do
  factory :question do
    association :author, factory: :user
    title { 'MyQuestionString' }
    body { 'MyQuestionText' }

    trait :invalid do
      title { nil }
    end

    factory :question_with_answers do
      title { 'MyQuestionString1' }
      body { 'MyQuestionText1' }

      transient do
        answers_count { 3 }
      end

      answers do
        Array.new(answers_count) { association(:answer) }
      end
    end

    factory :question_with_votes do
      transient do
        votes_count { 3 }
      end

      after(:create) do |question, evaluator|
        create_list(:vote, evaluator.votes_count, :for_question, votable: question)
        question.reload
      end
    end
  end
end
