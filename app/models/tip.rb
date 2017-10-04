class Tip < ApplicationRecord
  belongs_to :member
  
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500}
  validates :member_id, presence: true
  
  #part of paginate, latest tip created is the first one to show
  default_scope -> { order(updated_at: :desc) }
  
  has_many :tip_skills
  has_many :skills, through: :tip_skills
  # if a tip is deleted, the comments associated with that tip are deleted 
  has_many :comments, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  
  def thumbs_up_total
    self.likes.where(like: true).size
  end
  
  def thumbs_down_total
    self.likes.where(like: false).size
  end
  
end