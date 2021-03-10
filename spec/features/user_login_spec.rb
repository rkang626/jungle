require 'rails_helper'

RSpec.feature "User login", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create! first_name: 'Ryan', last_name: 'Kang', email: 'ryan@test.com', password: 'password'

  end

  scenario "User logs in successfully and is redirected to the home page" do
    # VISIT HOME PAGE
    visit root_path

    # NAVIGATE TO LOGIN PAGE
    find_link("Login").click

    # FILL IN LOGIN FORM AND SUBMIT
    fill_in("email", with: "ryan@test.com")
    fill_in("password", with: "password")
    find("input[name='commit']").click

    # VALIDATE THAT USER WAS LOGGED IN
    expect(page).to have_content("Signed in as Ryan")
    expect(page).to have_link("Logout", href: "/logout")
    
    # DEBUG / VERIFY
    page.save_screenshot
  end

end
