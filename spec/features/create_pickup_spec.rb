require 'rails_helper'

feature 'user creates pickup', %Q{
  As an authorized user
  I want to create new pickup
  So that I can know what when and where needs to be picked-up
} do

  before :each do
    @user = FactoryGirl.create(:user)
    login_as(@user)
  end

  scenario 'creates with valid data' do
    @customer = FactoryGirl.create(:customer)
    @location = FactoryGirl.create(:location)

    visit new_pick_up_path

    save_and_open_page

    select 'New Customer', from: "Customer"
    select 'New Location', from: "Location"
    select Date.today, from: "Date"
    fill_in "Item", with: "Table"
    select "2", from: "Quantity"

    click_button "Create Pick-up"

    expect(page).to have_content('New pick-up was successfully added!')
    expect(PickUp.count).to eq 1
  end

  scenario 'create customer with empty data' do
    visit new_pick_up_path

    click_button "Create Pick-up"

    expect(page).to have_content("Customer can't be blank")
    expect(page).to have_content("Location can't be blank")
    expect(page).to have_content("Item can't be blank")
    expect(page).to have_content("Quantity can't be blank")
    expect(PickUp.count).to eq 0
  end


end
