class User < ApplicationRecord
  scope :guides, -> { where(guide: false) }
  has_many :plans, dependent: :destroy
  has_many :from_messages, class_name: "Message",
          foreign_key: "from_id", dependent: :destroy
  has_many :to_messages, class_name: "Message",
          foreign_key: "to_id", dependent: :destroy
  has_many :sent_messages, through: :from_messages, source: :from
  has_many :received_messages, through: :to_messages, source: :to
  has_many :active_requests, class_name:  "Request",
                                  foreign_key: "tourist_id",
                                  dependent:   :destroy
  has_many :passive_requsts, class_name:  "Request",
                                   foreign_key: "guide_id",
                                   dependent:   :destroy
  has_many :guides, through: :active_requests, source: :guide
  has_many :tourists, through: :passive_requests, source: :tourist
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:facebook]
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :number, presence: true, length: { minimum: 9 }
  validates :university, presence: true, length: { minimum: 4 }
  validates :major, presence: true, length: { minimum: 4 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_nil: true
  mount_uploader :picture, PictureUploader
  validates :picture, presence: true

  # userがいなければfacebookアカウントでuserを作成するメソッド
  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        # userモデルが持っているカラムをそれぞれ定義していく
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        user.image = auth.info.image
        user.uid = auth.uid
        user.provider = auth.provider

        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        user.skip_confirmation!
      end
    end
  end

  def remember_me
    true
  end
  
    # ガイドに申し込み
  # def apply(guide_user)
  #   self.guides << guide_user
  # end

  # ガイドへの申し込みキャンセルリクエスト
  # def cancel_request(guide_user)
  #   self.active_requests.find_by(guide_id: guide_user.id).destroy
  # end

  # ガイドに申し込んだことがあるかどうか
  # def applied?(guide_user)
  #   self.guides.include?(guide_user)
  # end

  # Send message to other user
  def send_message(other_user, room_id, content)
    from_messages.create!(to_id: other_user.id, room_id: room_id, content: content)
  end

end
