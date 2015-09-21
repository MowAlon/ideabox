require "rails_helper"

describe do
  before(:each) do
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
save_and_open_page
    find("option[value='1']").click
    click_on "Create Idea"

    @idea = Idea.find_by(title: "This is a title")
    click_on "Logout"
  end

  feature "User can't add an idea" do
    scenario "when not logged in" do
      visit new_idea_path

      expect(page).to have_content("Must be logged in to add an idea.")
    end
  end

  feature "User can't view an idea" do
    scenario "when not logged in" do
      visit "/ideas/#{@idea.id}"

      expect(page).to have_content("You're not authorized to do that")
    end
  end

  feature "User can't edit an idea" do
    scenario "when not logged in" do
      visit "/ideas/#{@idea.id}/edit"

      expect(page).to have_content("You're not authorized to do that")
    end
  end

  feature "User can't view an idea" do
    scenario "that belongs to a different user" do
      username = "user2"
      password = "password2"
      user = User.create(username: username, password: password)
      visit login_path
      fill_in "Username", with: username
      fill_in "Password", with: password
      click_on "login_button"

      visit new_idea_path
      fill_in "Title", with: "This is a title"
      fill_in "Description", with: "This describes my amazing idea."
      click_on "Create Idea"

      visit "/ideas/#{@idea.id}"

      expect(page).to have_content("You're not authorized to do that")
    end
  end

  feature "User can't edit an idea" do
    scenario "that belongs to a different user" do
      username = "user2"
      password = "password2"
      user = User.create(username: username, password: password)
      visit login_path
      fill_in "Username", with: username
      fill_in "Password", with: password
      click_on "login_button"

      visit new_idea_path
      fill_in "Title", with: "This is a different title"
      fill_in "Description", with: "My amazing idea is even better."
      click_on "Create Idea"

      visit "/ideas/#{@idea.id}/edit"

      expect(page).to have_content("You're not authorized to do that")
    end
  end

end
