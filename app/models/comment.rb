class Comment < ApplicationRecord
  validates :description, presence: true, length: { minimum: 4, maximum: 140}
  belongs_to :member
  belongs_to :tip
  validates :member_id, presence: true
  validates :tip_id, presence: true
  
  #part of paginate, latest comment created is the first one to show
  default_scope -> { order(updated_at: :desc) }
  
end