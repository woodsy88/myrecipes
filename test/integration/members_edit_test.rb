require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
  
  def setup
     @member = Member.create!(membername: "mashur", email: "andrew@farts.com", 
                            password: "password", password_confirmation: "password")
                            
  end
  
  test "reject an invalid edit" do
    get edit_member_path(@member)
    assert_template 'members/edit'
    patch member_path(@member), params: { member: {membername: " ", email: "andrew@example.com" }}
   
    assert_template 'members/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    get edit_member_path(@member)
    assert_template 'members/edit'
    patch member_path(@member), params: { member: {membername: "andrew1", email: "andrew1@example.com" }}
   
    assert_redirected_to @member
    assert_not flash.empty?
    @member.reload
    assert_match "andrew1", @member.membername
    assert_match "andrew1@example.com", @member.email
  end
  
  # test "the truth" do
  #   assert true
  # end
end
