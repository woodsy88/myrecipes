class Like < ApplicationRecord
 belongs_to :member
 belongs_to :tip 
  
  #a member_id can only be associated with a like and a tip once.
  validates_uniqueness_of :member, scope: :tip
end