require "application_system_test_case"

class TypesTest < ApplicationSystemTestCase
  test "types - index" do
    visit "/types"
    assert_selector "h2", text: "Hitting array"
  end
end
