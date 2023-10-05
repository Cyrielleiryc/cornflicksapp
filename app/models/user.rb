class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :groups, through: :subscriptions
  has_many :groups_as_creator, class_name: "Group", foreign_key: :creator_id, dependent: :destroy
  has_many :recommendations, dependent: :destroy

  validates :username, presence: true
end
