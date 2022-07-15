FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }

    trait :invalid do
      title { nil }
    end
    
    factory :question_with_answers do
      title { 'MyString1' }
      body { 'MyText1' }
      
      transient do
        answers_count { 2 }
      end
      
      answers do
        Array.new(answers_count) { association(:answer) }
      end
    end
  end
end
