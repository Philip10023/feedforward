class Feed < ApplicationRecord
  include PgSearch

  validates :url, presence: true
  validates :description, presence: true
  validates :user, presence: true

  belongs_to :user
  has_many :reviews

  pg_search_scope :search_game_only, against: [:title, :description]
  scope :search, ->(query) { search_game_only(query) if query.present? }

end
