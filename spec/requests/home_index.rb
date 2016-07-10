require 'rails_helper'

RSpec.feature "Static pages", :type => :feature do
  scenario "Visiting the home page" do
    visit "/"
    expect(page).to have_title "Catlog"

  end
end
