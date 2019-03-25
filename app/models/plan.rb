class Plan < ApplicationRecord
  mount_uploader :image, PictureUploader
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :comments
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :tag, presence: true
  validates :content, presence: true, length: { maximum: 1000 }
  validates :image, presence: true

  def self.search(search) #ここでのself.はPlan.を意味する
    plans = self.all

    if search[:kwd].present?
      plans = plans.where(['name LIKE ? OR content LIKE ? ', "%#{search[:kwd]}%", "%#{search[:kwd]}%"]) # 検索とnameの部分一致を表示。
    end
    if search[:tag].present?
      plans = plans.where(['tag LIKE ? ', "#{search[:tag]}%"])
    end
    return plans
  end
end
