require 'rails_helper'

describe "The search", :type => :feature do

  # TODO
  # populate db with seeds
  # find a way to get the MC to test
  before do
    @prod = Product.create(
      :product_name => 'p1',
      :price => '32000',
      :quantity => '10',
      :instagram_image => 'IMAGE',
      :description => 'DESCRIPTION PROD',
      :store_owner => '@user'
    )


  #  User.make(:email => 'user@example.com', :password => 'password')
  end

  it "goes to 404 when products doenst exist" do
    visit '/'
    within("#searchModal") do
      fill_in 'search', :with => 'kzklyasf'
    end
    click_button 'Buscar'
    expect(page).to have_content 'Producto no encontrado'
  end

  it "goes to home whithout search params" do
    visit '/'
    within("#searchModal") do
      fill_in 'search', :with => ''
    end
    click_button 'Buscar'
    expect(page).to have_content 'Los productos de instagram en un sólo lugar'
  end

  it "goes to product page" do
    visit '/'
    within("#searchModal") do
      fill_in 'search', :with => @prod.shortened_urls.last.unique_key
    end
    click_button 'Buscar'
    expect(page).to have_content '$32,000'
  end

end
