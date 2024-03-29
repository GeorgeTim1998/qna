class Answer < ApplicationRecord
  include Votable

  default_scope { order(best: :desc) }

  belongs_to :question
  belongs_to :author, class_name: 'User'

  has_many :links, dependent: :destroy, as: :linkable
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  has_many_attached :files

  validates :body, presence: true
  validates :best, uniqueness: { scope: :question_id }, if: :best
end
