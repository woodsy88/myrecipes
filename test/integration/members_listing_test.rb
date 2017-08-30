require 'test_helper'

class MembersListingTest < ActionDispatch::IntegrationTest
  
  def setup
     @member = Member.create!(membername: "mashur", email: "andrew@farts.com", 
                            password: "password", password_confirmation: "password")
     @member2 = Member.create!(membername: "mashur2", email: "andrew@f.com", 
                            password: "password", password_confirmation: "password")
    @adminuser = Member.create!(membername: "mashur1", email: "andrew@f2.com", 
                            password: "password", password_confirmation: "password", admin: true)
                            
  end
  
  
  test "should delete member" do
    sign_in_as(@adminuser, "password")
    get members_path
    assert_template 'members/index'
    assert_difference "Member.count", -1 do
      delete member_path(@member2)
    end
    assert_redirected_to members_path
    assert_not flash.empty?
    
  end
  
  test "tips should be deleted when member is deleted" do
    @member.save
    @member.tips.create!(name: "testing destroy", description: "testing destory function")
    assert_difference "Tip.count", -1 do
      @member.destroy
    end
  end
  
  
end
