require "rails_helper"

feature "User can logout" do
  scenario "after logging in" do
    user = User.create(username: "clarence", password: "password")
    visit login_path
    expect(current_path).to eq(login_path)

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "login_button"

    expect(current_path).to eq(profile_path)

    within ".profile-info" do
      expect(page).to have_content("Clarence's Account Page")
    end

    click_on "Logout"
    expect(current_path).to eq(root_path)
    visit profile_path
    expect(page).to have_content("You're not logged in. Please login to view your account info.")
  end
end
