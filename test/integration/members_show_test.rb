require 'test_helper'

class MembersShowTest < ActionDispatch::IntegrationTest
 
 def setup
   @member = Member.create!(membername: "mashur", email: "andrew@farts.com", 
                            password: "password", password_confirmation: "password")
    @tip = Tip.create(name: "fast forward", description: "skate hard", member: @member)
    @tip2 = @member.tips.build(name: "defense", description: "no goals")
    @tip2.save
 end
 
 test "should get members show" do
   get member_path(@member)
   assert_template 'members/show'
   assert_select "a[href=?]", tip_path(@tip), text: @tip.name
   assert_select "a[href=?]", tip_path(@tip2), text: @tip2.name
   assert_match @tip.description, response.body
   assert_match @tip2.description, response.body
   
 end
 
 
  # test "the truth" do
  #   assert true
  # end
end
