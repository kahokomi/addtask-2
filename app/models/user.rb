class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true, presence:true
  validates :introduction, length: {maximum: 50}

  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_user, through: :follower, source: :follower
  has_many :following_user, through: :followed, source: :followed

    def follow(user_id)
      unless self == user_id
        self.follower.find_or_create_by(followed_id: user_id)
      end
    end

    def unfollow(user_id)
      self.follower.find_by(followed_id: user_id).destroy
    end

    def following?(user)
      following_user.include?(user)
    end

  def self.search(search, search_word)
    if search == "forward_match"
      @user = User.where("name LIKE?", "#{search_word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?", "%#{search_word}")
    elsif search == "perfect_match"
      @user = User.where("name LIKE?", "#{search_word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?", "%#{search_word}%")
    else
      @user = User.all
    end
  end

end
