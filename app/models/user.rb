class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :questions, inverse_of: 'author', foreign_key: 'author_id', dependent: :destroy
  has_many :answers, inverse_of: 'author', foreign_key: 'author_id', dependent: :destroy

  def author_of?(resource)
    resource.author_id == id
  end
end
