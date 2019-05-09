class Hobby < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: {maximum: 30 }
  validates :kind, presence: true
  validates :category, presence: true
  validates :content, presence: true, length: {maximum: 500 }
  
  mount_uploader :thumbnail, ThumbnailUploader
  validates :thumbnail, presence: true

end
