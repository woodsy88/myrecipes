class Message < ApplicationRecord
  belongs_to :member
  validates :content, presence: true
  validates :member_id, presence: true
end