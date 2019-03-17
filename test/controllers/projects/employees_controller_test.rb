require 'test_helper'

class Projects::EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get projects_employees_new_url
    assert_response :success
  end

  test "should get create" do
    get projects_employees_create_url
    assert_response :success
  end

  test "should get index" do
    get projects_employees_index_url
    assert_response :success
  end

  test "should get destroy" do
    get projects_employees_destroy_url
    assert_response :success
  end

end
