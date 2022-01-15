class User < ApplicationRecord
  include Clearance::User

  has_many :questions, dependent: :destroy
  has_many :answers, foreign_key: :answerer, dependent: :destroy
end
