require 'rails_helper'

RSpec.feature "Visitor navigates from the home page to a product detail page by clicking on the product", type: :feature, js: true do

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

    # LOCATE FIRST PRODUCT AND CLICK
    first("article.product").find("a", text: "Details").click

    # VALIDATE THAT PRODUCT PAGE LOADED
    expect(page).to have_content(@product.name)
    expect(page).to have_css "section.products-show"
    expect(page).to have_css "article.product-detail"
    
    # DEBUG / VERIFY
    page.save_screenshot
  end

end