class Group < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  belongs_to :creator, class_name: "User"

  validates :name, presence: true

  after_commit :subscribe_creator, on: %i[create]

  private

  def subscribe_creator
    Subscription.create!(group: self, user: self.creator)
  end
end
