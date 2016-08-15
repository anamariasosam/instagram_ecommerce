require 'rails_helper'

RSpec.describe Store, type: :model do

  it "has a valid factory" do
    FactoryGirl.create(:store).should be_valid
  end

  it "is invalid without name" do
    FactoryGirl.create(:store, name: nil).should_not be_valid
  end

  it "is invalid without city" do
    FactoryGirl.create(:store, city: nil).should_not be_valid
  end

  it "is invalid without country" do
    FactoryGirl.create(:store, country: nil).should_not be_valid
  end

  it "is invalid without email" do
    FactoryGirl.create(:store, email: nil).should_not be_valid
  end

  it "is invalid without phone_number" do
    FactoryGirl.create(:store, phone_number: nil).should_not be_valid
  end

  it "does not allow duplicate email for different users" do
    FactoryGirl.create(:store, email: "x@x.com")
    FactoryGirl.build(:store, email: "x@x.com").should_not be_valid
  end
end
