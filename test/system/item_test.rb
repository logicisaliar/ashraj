require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  test "items - index" do
    visit "/items"
    assert_selector "h1", text: "Items"
  end
  test "items - new" do
    visit "/items/new"
    assert_selector "h1", text: "Please add new Item"
  end
end
