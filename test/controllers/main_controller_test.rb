require "test_helper"

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get user" do
    get main_user_url
    assert_response :success
  end

  test "should get admin" do
    get main_admin_url
    assert_response :success
  end
end
