require "application_system_test_case"

class HarmonicDetailsTest < ApplicationSystemTestCase
  test "Harmonic Details - index" do
    visit "/harmonic_details"
    assert_selector "h1", text: "HSN Details"
  end

  test "Harmonic Details - new" do
    visit "/harmonic_details/new"
    assert_selector "h1", text: "Please add new HSN Chapter"
  end
end
