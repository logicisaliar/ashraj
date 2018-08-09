require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  test "categories - index" do
    visit "/categories"
    assert_selector "h2", text: "Hitting array"
  end

  test "categories - new" do
    visit "/categories/new"
    assert_selector "h1", text: "Please add new Category"
  end
end
