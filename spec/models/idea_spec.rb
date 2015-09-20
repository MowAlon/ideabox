require 'rails_helper'

RSpec.describe Idea, type: :model do
  let(:user){User.create(username: "user", password: "password")}

  let(:valid_attributes){
    {title: "Cool idea", description: "Sweet description", user_id: user.id}
  }

  let(:idea){
    Idea.create(valid_attributes)
  }

  it "successfully adds an idea to the database" do
    expect(idea.title).to eq("Cool idea")
    expect(Idea.count).to eq(1)
  end

  it "has a title" do
    expect(idea.title).to eq("Cool idea")
  end

  it "has a description" do
    expect(idea.description).to eq("Sweet description")
  end

  it "won't create a idea without a title" do
    expect(idea).to be_valid

    idea.title = nil
    expect(idea).to be_invalid
  end

  it "will create a idea without a description" do
    expect(idea).to be_valid

    idea.description = nil
    expect(idea).to be_valid
  end

end
