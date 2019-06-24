require 'test_helper'

class UserTest < ActiveSupport::TestCase
  #CREATE TESTS
  test "should not create a user without any fields" do
    user = User.new
    assert_not user.save, "Tried to create a user with no fields"
  end
  
  test "should not create a user without password" do
    user = User.new(email: "test@test.com")
    assert_not user.save, "Tried to create a user with no password"
  end

  test "should not create a user without email" do
    user = User.new(password: "nopass")
    assert_not user.save, "Tried to create a user with no email"
  end

  test "should not create a user with a invalid email" do
    user = User.new(email: "test", password: "nopass")
    assert_not user.save, "Tried to create a user with a invalid password"
  end

  test "should create a user with a encrypted password" do
    @user = User.new(email: "test@test.com", password: "nopass")
    assert @user.save, "User created successfully"    
  end

  test "should not allow the creation of two users with the same email" do
    user = User.new(email: "email@email.com", password: "nopass")
    assert_not user.save, "Should return an error of uniqueness"  
  end

  # UPDATE TESTS
  test "should not allow to update the user with empty password" do
    user = User.find_by_email('email@email.com')
    assert_not user.update(password: ""), "Should not allow the saving of a empty password"
  end

  test "should not allow to update a user with a invalid email" do
    user = User.find_by_email('email@email.com')
    assert_not user.update(email: ""), "Should not allow the saving of a empty email"
    assert_not user.update(email: "test"), "Should not allow the saving of a invalid email"
  end

  test "should not allow to update a user with a duplicated password" do
    user = User.find_by_email('email@email.com')
    assert_not user.update(email: "email2@email.com"), "Should not allow updates for duplicated email"
  end 

  test "should update an user user info" do
    user = User.find_by_email('email@email.com')
    assert user.update(email: "email2@email2.com", password: "nopass2"), "User updated"
  end
end
