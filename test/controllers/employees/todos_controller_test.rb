require 'test_helper'

class Employees::TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employees_todos_index_url
    assert_response :success
  end

  test "should get edit" do
    get employees_todos_edit_url
    assert_response :success
  end

  test "should get update" do
    get employees_todos_update_url
    assert_response :success
  end

end
