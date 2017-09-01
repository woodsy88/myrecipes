class Skill < ApplicationRecord
  validates :name, presence: true, length: {minimum: 3, maximum: 25}
  validates_uniqueness_of :name
  
  has_many :tip_skills
  has_many :tips, through: :tip_skills
end