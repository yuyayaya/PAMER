class Like < ApplicationRecord
  belongs_to :plan
  belongs_to :user
  validates_uniqueness_of :plan_id, scope: :user_id
end
