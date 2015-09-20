require "rails_helper"

feature "User can login" do
  scenario "with valid attributes" do
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
  end
end
