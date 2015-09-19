require "rails_helper"

feature "User can sign up" do
  scenario "with valid attributes" do
    visit "/signup"
    expect(current_path).to eq("/signup")

    fill_in "Username", with: "clarence"
    fill_in "Password", with: "password"
    click_on "Sign up"

    expect(current_path).to eq("/profile")

    within ".profile-info" do
      expect(page).to have_content("Clarence's Account Page")
    end
  end
end
