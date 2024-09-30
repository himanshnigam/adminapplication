class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :messages, dependent: :destroy
  has_many_attached :images
  
  validates :title, presence: true
  validates :description, presence: true
  validates :category, presence: true

  def self.ransackable_associations(auth_object = nil)
    %w[user category messages]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id title description created_at updated_at user_id category_id]  
  end
  
end
