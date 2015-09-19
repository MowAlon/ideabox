require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes){
    {username: "clarence", password: "password"}
  }

  let(:user){
    User.create(valid_attributes)
  }

  it "successfully adds a user to the database" do
    expect(user.username).to eq("clarence")
    expect(User.count).to eq(1)
  end

  it "has a username" do
    expect(user.username).to eq("clarence")
  end

  it "has a password" do
    expect(user.authenticate(user.password)).to eq(user)
  end

  it "won't create a user without a username" do
    expect(user).to be_valid

    user.username = nil
    expect(user).to be_invalid
  end

  it "won't create a user without a password" do
    expect(user).to be_valid

    user.password = nil
    expect(user).to be_invalid
  end




end
