require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  
  test "should get home" do
    #pages controller,home action
    get pages_home_url  
    assert_response :success
  
  end
  
  test "should get root" do
    get root_url
    assert_response :success
  end

end
