require 'test_helper'

class CatalogControllerTest < ActionController::TestCase
  test "should get flipbook" do
    get :flipbook
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
