class Group < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  belongs_to :creator, class_name: "User"

  validates :name, presence: true

  after_commit :subscribe_creator, on: %i[create]
  after_commit :generate_shareablecode, on: %i[create]

  private

  def subscribe_creator
    Subscription.create!(group: self, user: self.creator)
  end

  def generate_shareablecode
    self.shareablecode = "#{('A'..'Z').to_a.sample(4).join}#{self.id}"
    self.save!
  end
end
