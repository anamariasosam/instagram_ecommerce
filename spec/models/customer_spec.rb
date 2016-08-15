require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:customer).should be_valid
  end

  it "is invalid without city" do
    FactoryGirl.create(:customer, city: nil).should_not be_valid
  end

  it "is invalid without country" do
    FactoryGirl.create(:customer, country: nil).should_not be_valid
  end

  it "is invalid without email" do
    FactoryGirl.create(:customer, email: nil).should_not be_valid
  end

  it "is invalid without phone_number" do
    FactoryGirl.create(:customer, phone_number: nil).should_not be_valid
  end

  it "does not allow duplicate email for different users" do
    FactoryGirl.create(:customer, email: "x@x.com")
    FactoryGirl.build(:customer, email: "x@x.com").should_not be_valid
  end

end
