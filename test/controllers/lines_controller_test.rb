require 'test_helper'

class LinesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get lines_new_url
    assert_response :success
  end

  test "should get edit" do
    get lines_edit_url
    assert_response :success
  end

  test "should get index" do
    get lines_index_url
    assert_response :success
  end

end
