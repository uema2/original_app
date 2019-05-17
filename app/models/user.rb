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
  
  has_many :from_messages, class_name: "Message",
            foreign_key: "from_id", dependent: :destroy
  has_many :to_messages, class_name: "Message",
            foreign_key: "to_id", dependent: :destroy
  has_many :sent_messages, through: :from_messages, source: :from
  has_many :received_messages, through: :to_messages, source: :to
  
  def self.search(params)
    results = all.order(created_at: :desc)
    results = results.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    results = results.where('gender = ?', "#{params[:search_gender]}") if params[:search_gender].present?
    results = results.where('age = ?', "#{params[:search_age]}") if params[:search_age].present?
    results
  end
  
  def send_message(other_user, room_id, content)
    from_messages.create!(to_id: other_user.id, room_id: room_id, content: content)
  end
end
