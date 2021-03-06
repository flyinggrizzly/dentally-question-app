class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :answerer, class_name: 'User'

  validates :body, presence: true

  delegate :email, to: :answerer, prefix: true
end
