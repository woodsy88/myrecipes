require 'test_helper'

class TipTest < ActiveSupport::TestCase
 
  def setup
    @member = Member.create!(membername: "andy", email: "andy@gmail.com")
    @tip = @member.tips.build(name: "andrew", description: "forward skating")
  end
  
  test "tip without member should be invalid" do
    @tip.member_id = nil
    assert_not @tip.valid?
  end
  
  test "tip should be valid" do
    # assert will expect a non-nil object or true
    assert @tip.valid?
  end
  
  test "name should be present" do
    @tip.name = " "
    # assert_not expects nil or false 
    assert_not @tip.valid?
  end
  
  test "description should be present" do
    @tip.description = " "
    assert_not @tip.valid?
  end
  
  test "description shouldnt be less then 5 characters" do
   #without validations added to the actual Tip model, this 3 char description was returning true, thus failing test, since assert_not expects false, once validations were added, it was returning false and passing the test
   
    @tip.description = "a" * 3
    assert_not @tip.valid?
  end
  
  test "descriptionshouldnt be more then 500 characters" do
    @tip.description ="a" *   501
    assert_not @tip.valid?
  end
  
end