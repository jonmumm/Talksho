require 'test_helper'

class StatesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get created" do
    get :created
    assert_response :success
  end

end
