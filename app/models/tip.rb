class Tip < ApplicationRecord
  belongs_to :member
  
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500}
  validates :member_id, presence: true
end