require "rails_helper"

feature "User can edit" do
  scenario "after existing idea" do
    username = "user"
    password = "password"
    user = User.create(username: username, password: password)
    visit login_path
    fill_in "Username", with: username
    fill_in "Password", with: password
    click_on "login_button"

    visit new_idea_path
    fill_in "Title", with: "This is a title"
    fill_in "Description", with: "This describes my amazing idea."
    click_on "Create Idea"

    visit edit_idea_path
    fill_in "Title", with: "New title"
    fill_in "Description", with: "New description."
    click_on "Update Idea"

    expect(current_path).to eq(profile_path)
    within ".ideas" do
      expect(page).to have_content("New title")
    end
  end
end
