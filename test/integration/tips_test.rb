require 'test_helper'

class TipsTest < ActionDispatch::IntegrationTest
  
  
  def setup
    @member = Member.create!(membername: "mashur", email: "andrew@farts.com")
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
    
      
    get tip_path(@tip)
    assert_template 'tips/show'
    assert_match @tip.name, response.body
    assert_match @tip.description, response.body
    assert_match @member.membername, response.body
      
  end
  
  # test "the truth" do
  #   assert true
  # end
end
