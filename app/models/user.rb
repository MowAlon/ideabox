class User < ActiveRecord::Base
  has_secure_password
  has_many :ideas
  has_many :categories, through: :ideas

  validates :username, :password, presence: true
end
