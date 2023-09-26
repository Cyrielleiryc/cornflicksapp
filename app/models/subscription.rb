class Subscription < ApplicationRecord
  attr_accessor :group_shareablecode
  
  belongs_to :user
  belongs_to :group

  validates :group, uniqueness: { scope: :user }
end
