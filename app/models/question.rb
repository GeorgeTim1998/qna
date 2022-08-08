class Question < ApplicationRecord
  include Votable

  belongs_to :author, class_name: 'User'

  has_one :achievement, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_many :comments, as: :commentable, dependent: :destroy

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :achievement, reject_if: :all_blank

  validates :title, :body, presence: true

  def best_answer
    Answer.find_by(best: true)
  end

  def update_best_answer(answer)
    best_answer&.update!(best: false)
    answer.update!(best: true)
    achievement&.update!(winner: answer.author)
  end
end
