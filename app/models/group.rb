class Group < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  belongs_to :creator, class_name: "User"

  validates :name, presence: true
end
