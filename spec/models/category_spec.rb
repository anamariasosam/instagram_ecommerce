# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do

  it "has a valid factory" do
    FactoryGirl.create(:category).should be_valid
  end

  it "is invalid without name" do
    FactoryGirl.build(:category, name: nil).should_not be_valid
  end
end
