class Review < ApplicationRecord

  validates :feed_id, presence: true
  validates :user_id, presence: true

  belongs_to :feed
  belongs_to :user
  has_many :updowns
end
