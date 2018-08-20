require 'test_helper'

class PackingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get packings_index_url
    assert_response :success
  end

end
