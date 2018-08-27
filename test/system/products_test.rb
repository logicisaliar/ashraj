require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  test "products - index" do
    visit "/products"
    assert_selector "h1", text: "Products"
  end
  test "products - new" do
    visit "/products/new"
    assert_selector "h1", text: "Please add new Product"
  end
end
