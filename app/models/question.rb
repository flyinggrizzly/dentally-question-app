class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

  delegate :email, to: :user, prefix: true

  def has_answers?
    answers.count > 0
  end
end
