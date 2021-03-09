require 'rails_helper'

RSpec.feature "Visitor adds a product to their cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @product = @category.products.create!(
      name: Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )

  end

  scenario "They see the product detail page" do
    # VISIT HOME PAGE
    visit root_path
    expect(page).to have_content("My Cart (0)")

    # LOCATE FIRST PRODUCT AND ADD TO CART
    first("article.product").find_button("Add").click

    # VALIDATE THAT PRODUCT WAS ADDED TO CART
    expect(page).to have_content("My Cart (1)")
    
    # DEBUG / VERIFY
    page.save_screenshot
  end

end
