require 'test_helper'

class PincodesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pincodes_new_url
    assert_response :success
  end

  test "should get edit" do
    get pincodes_edit_url
    assert_response :success
  end

  test "should get index" do
    get pincodes_index_url
    assert_response :success
  end

end
