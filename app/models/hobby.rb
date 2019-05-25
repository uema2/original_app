class Hobby < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: {maximum: 30 }
  validates :kind, presence: true
  validates :category, presence: true
  validates :content, presence: true, length: {maximum: 500 }
  
  mount_uploader :thumbnail, ThumbnailUploader
  validates :thumbnail, presence: true
  
  has_many :clips, dependent: :destroy
  has_many :users, through: :clips
  
  def self.search(params)
    results = all.order(created_at: :desc)
    results = results.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
    results = results.where('kind = ?', params[:search_kind]) if params[:search_kind].present?
    results = results.where('category = ?', params[:search_category]) if params[:search_category].present?
    results 
  end
  
  
end
