class Message < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id content user_id post_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[post user]
  end
end
