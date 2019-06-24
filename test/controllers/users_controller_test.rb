require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should not allow create a user without valid params" do
    post '/users', params: {user: {email:"newemail@email.com", passwords: "123456"}}
    assert_response 400
  end

  test "should create a new user" do
    post '/users', params: {user: {email:"newemail@email.com", password: "123456"}}
    assert_response 200
  end
  
  test "should return an error if trying to login with a wrong user " do 
    post '/login', params: {user: {email: 'email@email.com', password: 's'}}
    assert_response 400
  end

  test "should authenticate a user" do 
    post '/login', params: {user: {email: 'email@email.com', password: 'secret'}}
    assert_response 200
  end
end
