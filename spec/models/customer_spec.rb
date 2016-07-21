# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  store_name             :string
#  phone_number           :string
#  delivery_info          :text
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
