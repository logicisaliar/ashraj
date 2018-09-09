require "application_system_test_case"

class StatesTest < ApplicationSystemTestCase
  test "states - index" do
    visit "/states"
    assert_selector "h1", text: "States"
  end
end
