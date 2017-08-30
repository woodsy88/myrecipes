require 'test_helper'

class TipsTest < ActionDispatch::IntegrationTest
  
  
  def setup
    @member = Member.create!(membername: "mashur", email: "andrew@farts.com", 
                            password: "password", password_confirmation: "password")
    @tip = Tip.create(name: "fast forward", description: "skate hard", member: @member)
    @tip2 = @member.tips.build(name: "defense", description: "no goals")
    @tip2.save
  end
  
  
  test "should get recipes index" do
    get tips_url
    assert_response :success
  end
  
  test "should get tips listing" do
    get tips_path
    assert_template 'tips/index'
    assert_select "a[href=?]", tip_path(@tip), text: @tip.name
    assert_select "a[href=?]", tip_path(@tip2), text: @tip2.name
  end
  
  test "should get tips show" do
    sign_in_as(@member, "password")
    get tip_path(@tip)
    assert_template 'tips/show'
    assert_match @tip.name, response.body
    assert_match @tip.description, response.body
    assert_match @member.membername, response.body
    assert_select 'a[href=?]', edit_tip_path(@tip), text: "Edit this tip"
    assert_select 'a[href=?]', tip_path(@tip), text: "Delete this tip"
    assert_select 'a[href=?]', tips_path, text: "Return to tips listing"
      
  end
  
  test "create new valid tip" do
    sign_in_as(@member, "password" )
    get new_tip_path
    assert_template 'tips/new'
    name_of_tip = "skating"
    description_of_tip = "skate hard, skate fast"
    assert_difference 'Tip.count', 1 do 
      post tips_path, params: { tip:{name: name_of_tip, description: description_of_tip}}
    end
    
    follow_redirect!
    assert_match name_of_tip, response.body
    assert_match description_of_tip, response.body
    
  end
  
  test "reject invalid tip submissions" do
   sign_in_as(@member, "password")
   get new_tip_path
   assert_template 'tips/new'
   assert_no_difference 'Tip.count' do
     post tips_path, params: { tip: {name: " ", description: " "}}
   end
    assert_template 'tips/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
