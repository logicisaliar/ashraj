require 'test_helper'

class BrokerageControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get brokerage_edit_url
    assert_response :success
  end

  test "should get index" do
    get brokerage_index_url
    assert_response :success
  end

  test "should get show" do
    get brokerage_show_url
    assert_response :success
  end

end
