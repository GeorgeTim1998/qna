class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :achievements, inverse_of: 'winner', foreign_key: 'winner_id', dependent: :destroy
  has_many :answers, inverse_of: 'author', foreign_key: 'author_id', dependent: :destroy
  has_many :questions, inverse_of: 'author', foreign_key: 'author_id', dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_to, through: :subscriptions, source: :question

  def author_of?(resource)
    resource&.author_id == id
  end

  def voted_for?(resource)
    Vote.find_by(user: self, votable: resource).present?
  end
end
