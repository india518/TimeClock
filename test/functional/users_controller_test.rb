require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get only:" do
    get :only:
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
