require 'test_helper'

class MembersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
     @member = Member.create!(membername: "mashur", email: "andrew@farts.com", 
                            password: "password", password_confirmation: "password")
  end
 
  test "invalid is rejected" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: " ", password: " "}}
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    #after is fails we go to another route, and there should be no flash showing up
    get root_path
    assert flash.empty?
  end 
  
  
  test "valid login credentials accepted and begin session" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {email: @member.email, password: @member.password}}
    assert_redirected_to @member
    follow_redirect! 
    assert_template 'members/show'
    assert_not flash.empty?
    #when a user is logged in, there is no login path but a logout path
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    #
    assert_select "a[href=?]", member_path(@member)
    assert_select "a[href=?]", edit_member_path(@member)
  end
  
end
