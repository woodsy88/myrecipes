require 'test_helper'

class MembersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "should get signup path" do
    get signup_path
    assert_response :success
  end
  
  test "get a succesful signup" do
    get signup_path
    assert_response :success
  end
  
  test "reject an invalid signup" do
    get signup_path
    assert_no_difference "Member.count" do
      post members_path, params: { member: {membername: " ", email: " ", password: "password",
                                            password_confirmation: " "}}
    end
    assert_template 'members/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid signup" do
    get signup_path
    assert_difference "Member.count", 1 do
      post members_path, params: { member: {membername: "andrew", email: "andrew@woods.com", password: "password",
                                            password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'members/show'
    assert_not flash.empty?
  end
  
  
end
