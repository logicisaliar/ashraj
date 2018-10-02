require 'test_helper'

class MailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get mails_new_url
    assert_response :success
  end

  test "should get edit" do
    get mails_edit_url
    assert_response :success
  end

  test "should get index" do
    get mails_index_url
    assert_response :success
  end

end
