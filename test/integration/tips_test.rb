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
    assert_match @tip.name, response.body
    assert_match @tip2.name, response.body
  end
  
  # test "the truth" do
  #   assert true
  # end
end
