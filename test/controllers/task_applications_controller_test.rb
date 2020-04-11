require 'test_helper'

class TaskApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get task_application_create_url
    assert_response :success
  end

  test "should get destroy" do
    get task_application_destroy_url
    assert_response :success
  end

end
