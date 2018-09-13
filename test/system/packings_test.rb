require "application_system_test_case"

class PackingsTest < ApplicationSystemTestCase
  test "packings - index" do
    visit "/packings"
    assert_selector "h1", text: "Packings:"
  end
end
