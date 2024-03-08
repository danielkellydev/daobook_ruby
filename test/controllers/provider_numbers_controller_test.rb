require "test_helper"

class ProviderNumbersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get provider_numbers_index_url
    assert_response :success
  end

  test "should get new" do
    get provider_numbers_new_url
    assert_response :success
  end

  test "should get create" do
    get provider_numbers_create_url
    assert_response :success
  end

  test "should get edit" do
    get provider_numbers_edit_url
    assert_response :success
  end

  test "should get update" do
    get provider_numbers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get provider_numbers_destroy_url
    assert_response :success
  end
end
