class Request < ApplicationRecord
    belongs_to :guide, class_name: "User"
    belongs_to :tourist, class_name: "User"
    validates :guide_id, presence: true
    validates :tourist_id, presence: true
    belongs_to :plan
end
