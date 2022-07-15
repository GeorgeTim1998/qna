FactoryBot.define do
  factory :question do
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
  end
end
