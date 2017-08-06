require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  
  def setup
    @member = Member.new(membername: "andrew", email: "andrew@gmail.com")
  end
  
  test "should be valid" do
    assert @member.valid?
  end
  
  test "name should be present" do
    @member.membername = " "
    assert_not @member.valid?
  end
  
  test "name should be less the 30 characters" do
    @member.membername = "a" * 31
    assert_not @member.valid?
  end
  
  test "email should be present" do
    @member.email = " "
    assert_not @member.valid?
  end
  
  test "email should not be too long" do
    @member.email = "a" * 255
    assert_not @member.valid?
  end
  
  test "email shoud accept correct format" do
    
    valid_emails = %w[user@example.com ANDREW@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
    
    valid_emails.each do |valids|
      @member.email = valids
      assert @member.valid?, "#{valids.inspect} should be valid"
    end
    
  end
  
  
  test "should reject invalid addresses" do 
    invalid_emails = %w[mashur@example andrew@example,com andrew.name@gmail. joe@foo+poo.com]
    
    invalid_emails.each do |invalids|
      @member.email = invalids
      assert_not @member.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case sensitive" do
    duplicate_member = @member.dup
    duplicate_member.email = @member.email.upcase
    @member.save
    assert_not duplicate_member.valid?
  end
  
  test "email should be lower case before hitting db" do
    mixed_email = "JohN@ExampLe.com"
    @member.email = mixed_email
    @member.save
    assert_equal mixed_email.downcase, @member.reload.email 
  end
  
end