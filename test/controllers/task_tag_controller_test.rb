require 'test_helper'

class TaskTagControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get task_tag_create_url
    assert_response :success
  end

  test "should get destroy" do
    get task_tag_destroy_url
    assert_response :success
  end

end
