class User < ApplicationRecord
  include Clearance::User

  has_many :questions, dependent: :destroy
end
