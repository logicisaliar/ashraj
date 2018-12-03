require 'test_helper'

class OuterpackingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get outerpackings_index_url
    assert_response :success
  end

  test "should get new" do
    get outerpackings_new_url
    assert_response :success
  end

  test "should get edit" do
    get outerpackings_edit_url
    assert_response :success
  end

end
