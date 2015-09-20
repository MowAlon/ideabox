require "rails_helper"

feature "User can delete" do
  scenario "an existing idea" do
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
    idea = Idea.find_by(title: "This is a title")

    click_link "delete"

    expect(current_path).to eq(profile_path)
    within ".ideas" do
      expect(page).to_not have_content("New title")
    end
  end
end
