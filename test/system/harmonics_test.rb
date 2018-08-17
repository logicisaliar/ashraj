require "application_system_test_case"

class HarmonicsTest < ApplicationSystemTestCase
  test "Harmonics - index" do
    visit "/harmonics"
    assert_selector "h1", text: "HSN codes"
  end

  test "Harmonics - new" do
    visit "/harmonics/new"
    assert_selector "h1", text: "Please add new HS Code"
  end
end
