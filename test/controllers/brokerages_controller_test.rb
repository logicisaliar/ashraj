require 'test_helper'

class BrokeragesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get brokerages_edit_url
    assert_response :success
  end

  test "should get index" do
    get brokerages_index_url
    assert_response :success
  end

  test "should get show" do
    get brokerages_show_url
    assert_response :success
  end

end
