require "application_system_test_case"

class UsesTest < ApplicationSystemTestCase
  test "uses - index" do
    visit "/uses"
    assert_selector "h2", text: "Hitting array"
  end
end
