class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :introduction, length: { maximum: 500 }
  
  has_many :hobbies
  
  def self.search(params)
    results = all.order(created_at: :desc)
    results = results.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    results = results.where('gender = ?', "#{params[:search_gender]}") if params[:search_gender].present?
    results = results.where('age = ?', "#{params[:search_age]}") if params[:search_age].present?
    results
  end
end
