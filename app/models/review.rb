class Review < ApplicationRecord
  after_create_commit { create_event }

  validates :feed_id, presence: true
  validates :user_id, presence: true

  belongs_to :feed
  belongs_to :user
  has_many :updowns

  private

  def create_event
    Event.create message: "A new comment has been created"
  end

end
