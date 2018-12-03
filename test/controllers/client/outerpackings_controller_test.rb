require 'test_helper'

class Client::OuterpackingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get client_outerpackings_new_url
    assert_response :success
  end

  test "should get index" do
    get client_outerpackings_index_url
    assert_response :success
  end

end
