class Micropost < ApplicationRecord
  belongs_to :user
 
  validates :content, presence: true, length: { maximum: 255 }

  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :user

  def favorite(user)
      favorites.find_or_create_by(user_id: user.id)
  end
    
  def unfavorite(user)
    favorite = favorites.find_by(user_id: user.id)
    favorite.destroy if favorite
  end
  
  def like?(user)
      likes.include?(user)
  end
end