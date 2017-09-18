module ApplicationCable
  class Connection < ActionCable::Connection::Base
    
    identified_by :current_member
    
    def connect 
      self.current_member = find_current_user
    end
    
    def disconnect
      
    end
    
    protected
    
    
    def find_current_user
      if current_member = Member.find_by(id: cookies.signed[:member_id] )
        current_member
      else
        reject_unauthorized_connection
      end
    end
    
  end
end
