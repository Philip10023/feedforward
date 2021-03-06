class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         validates :username, presence: true, uniqueness: true
         has_many :feeds
         has_many :chat_rooms, dependent: :destroy
         has_many :messages, dependent: :destroy
         has_many :reviews
end
