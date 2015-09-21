class Image < ActiveRecord::Base
  has_many :idea_images

  validates :address, presence: true
end
