class Group < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions
  has_many :recommendations, dependent: :destroy
  belongs_to :creator, class_name: "User"
  belongs_to :image

  validates :name, presence: true
  validates :name, length: { maximum: 20 }

  after_create :subscribe_creator
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
