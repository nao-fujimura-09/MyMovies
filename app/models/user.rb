class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :favorite_genres, dependent: :destroy
  has_many :watch_lists, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :views, dependent: :destroy
   
  # フォローした、されたの関係
  has_many :relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
   
  validates :name, presence:true
  validates :email, presence:true
   
  # プロフィール画像
  def get_profile_image(width, height)
    unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        profile_image.attach(io:File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed

  end
  
  # フォローする
  def follow(user_id)
    relationships.create!(followed_id: user_id)
  end
  
  # フォローを解除
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def followings?(user)
    followings.include?(user)
  end

end
