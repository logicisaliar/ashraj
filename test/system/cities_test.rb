require "application_system_test_case"

class CitiesTest < ApplicationSystemTestCase
  test "cities - index" do
    visit "/cities"
    assert_selector "h1", text: "Cities"
  end

  test "cities - new" do
    visit "/cities/new"
    assert_selector "h1", text: "City"
  end

end
