class Question < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true

  def best_answer
    Answer.find_by(best: true)
  end

  def update_best_answer(answer)
    best_answer&.update!(best: false)
    answer.update!(best: true)
  end
end
