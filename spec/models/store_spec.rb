# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  phone_number           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  instagram_id           :string
#  image                  :string
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  user_token             :string
#  instagram_account      :string
#  provider               :string
#  uid                    :string
#  slug                   :string
#  type                   :string(15)
#  details                :hstore
#  city                   :string
#  country                :string
#

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
