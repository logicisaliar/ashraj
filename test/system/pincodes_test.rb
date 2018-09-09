require "application_system_test_case"

class PincodesTest < ApplicationSystemTestCase
  test "pincodes - index" do
    visit "/pincodes"
    assert_selector "h1", text: "Pincodes"
  end

  test "pincodes - new" do
    visit "/pincodes/new"
    assert_selector "h1", text: "Pincode"
  end
end
