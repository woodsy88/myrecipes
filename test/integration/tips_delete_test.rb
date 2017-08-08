require 'test_helper'

class TipsDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @member = Member.create!(membername: "mashur", email: "andrew@farts.com")
    @tip = Tip.create(name: "fast forward", description: "skate hard", member: @member)
  end
  
  
  test "succesffuly delete a tip" do
    get tip_path(@tip)
    assert_template 'tips/show'
    assert_select 'a[href=?]', tip_path(@tip), text: "Delete this tip"
    assert_difference 'Tip.count', -1 do
      delete tip_path(@tip)
    end
    assert_redirected_to tips_path
    assert_not flash.empty?
  end
  
  
end
