class Recommendation < ApplicationRecord
  RECOMMENDATION_TYPES = %w[movie tv]
  belongs_to :user
  belongs_to :group

  validates :media_id, presence: true
  validates :comment, presence: true, length: { minimum: 6 }
  validates :media_type, inclusion: { in: RECOMMENDATION_TYPES }
end
