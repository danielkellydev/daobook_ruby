require "test_helper"

class PractitionersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get practitioners_show_url
    assert_response :success
  end

  test "should get edit" do
    get practitioners_edit_url
    assert_response :success
  end

  test "should get update" do
    get practitioners_update_url
    assert_response :success
  end
end
