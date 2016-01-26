require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get join_us" do
    get :join_us
    assert_response :success
  end

  test "should get partners" do
    get :partners
    assert_response :success
  end

end
