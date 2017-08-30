require 'test_helper'

class TipsEditTest < ActionDispatch::IntegrationTest

  def setup
    @member = Member.create!(membername: "mashur", email: "andrew@farts.com",
                              password: "password", password_confirmation: "password")
    @tip = Tip.create(name: "fast forward", description: "skate hard", member: @member)
  end

  test "reject invalid tip update" do
    sign_in_as(@member, "password")
    get edit_tip_path(@tip)
    assert_template 'tips/edit'
    patch tip_path(@tip), params: {tip: {name: " ", description: "some description"}}
    assert_template 'tips/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfully edit a tip" do
    sign_in_as(@member, "password")
    get edit_tip_path(@tip)
    assert_template 'tips/edit'
    updated_name = "updated tips name"
    updated_description = "updated recipe description"
    patch tip_path(@tip), params: { tip: { name: updated_name, description: updated_description } }
    assert_redirected_to @tip
    #follow_redirect!
    assert_not flash.empty?
    @tip.reload
    assert_match updated_name, @tip.name
    assert_match updated_description, @tip.description
  end



end
