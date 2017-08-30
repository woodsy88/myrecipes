require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
  
  def setup
     @member = Member.create!(membername: "mashur", email: "andrew@farts.com", 
                            password: "password", password_confirmation: "password")
    @member2 = Member.create!(membername: "mashur2", email: "andrew@f.com", 
                            password: "password", password_confirmation: "password")
    @adminuser = Member.create!(membername: "mashur1", email: "andrew@f2.com", 
                            password: "password", password_confirmation: "password", admin: true)                       
  end
  
  test "reject an invalid edit" do
     sign_in_as(@member, "password")
    get edit_member_path(@member)
    assert_template 'members/edit'
    patch member_path(@member), params: { member: {membername: " ", email: "andrew@example.com" }}
   
    assert_template 'members/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    sign_in_as(@member, "password")
    get edit_member_path(@member)
    assert_template 'members/edit'
    patch member_path(@member), params: { member: {membername: "andrew1", email: "andrew1@example.com" }}
   
    assert_redirected_to @member
    assert_not flash.empty?
    @member.reload
    assert_match "andrew1", @member.membername
    assert_match "andrew1@example.com", @member.email
  end
  
  test "accept edit attempt by admin user" do
    sign_in_as(@adminuser, "password")
    get edit_member_path(@member)
    assert_template 'members/edit'
    patch member_path(@member), params: { member: {membername: "andrew3", email: "andrew3@example.com" }}
   
    assert_redirected_to @member
    assert_not flash.empty?
    @member.reload
    assert_match "andrew3", @member.membername
    assert_match "andrew3@example.com", @member.email
  end
  
  test "redirect edit attempt by a non admin user" do
    sign_in_as(@member2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch member_path(@member), params: { member: {membername: updated_name, email: updated_email }}
   
    assert_redirected_to members_path
    assert_not flash.empty?
    @member.reload
    assert_match "mashur", @member.membername
    assert_match "andrew@farts.com", @member.email
  end
  
  # test "the truth" do
  #   assert true
  # end
end
