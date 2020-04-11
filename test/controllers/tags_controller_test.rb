require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get tag_create_url
    assert_response :success
  end

  test "should get destroy" do
    get tag_destroy_url
    assert_response :success
  end

  test "should get update" do
    get tag_update_url
    assert_response :success
  end

end
