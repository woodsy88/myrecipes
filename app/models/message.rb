class Message < ApplicationRecord
  belongs_to :member
  validates :content, presence: true
  validates :member_id, presence: true
  
  #grabs only the last 20 messages from the database
  def self.most_recent
    order(:created_at).last(20)
  end
  
  
end