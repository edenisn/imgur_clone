require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:user1)
  end

  test "should not save user with blank username" do
    @user.username = ""
    assert_not @user.save
  end

  test "should not save user with not unique username" do
    assert_raise("Username has already been taken") {
      User.create!(username: "john", email: "user@yahoo.com", encrypted_password: "12345678")
    }
  end

  test "should save user with unique username" do
    @user.username = "test"
    assert @user.save
  end

  test "should not save user with incorrect email" do
    @user.email = "user_email.com"
    assert_not @user.save

    @user.email = "user@email,com"
    assert_not @user.save

    @user.email = "user@email."
    assert_not @user.save
  end

  test "should not save user with duplicate email" do
    assert_raise("Email has already been taken") {
      User.create!(username: "test", email: "john@test.com", encrypted_password: "12345678")
    }
  end

  test "should save user with correct email" do
    @user.email = "test@test.com"
    assert @user.save
  end

  test "should not save user with blank password" do
    assert_raise("Password can't be blank") {
      User.create!(username: "john", email: "john@yahoo.com", password: "")
    }
  end

  test "should not save user with password < 8 symbols" do
    assert_raise("Password is too short (minimum is 8 characters)") {
      User.create!(username: "john", email: "john@yahoo.com", password: "1234567")
    }
  end

  test "should save user with password >= 8 symbols" do
    assert User.create!(username: "john1", email: "john1@yahoo.com", password: "12345678910")
  end

  test "should save user with correct username, email and password" do
    assert @user.save
  end
end
