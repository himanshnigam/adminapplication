class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :profile_image

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "name", "username", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
        
end
