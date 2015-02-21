require 'rails_helper'

feature 'user creates pickup', %Q{
  As an authorized user
  I want to create new pickup
  So that I can know where, when and what to pickup
  } do

    before :each do
      @user = FactoryGirl.create(:user)
      login_as(@user)
    end

    scenario 'creates with valid data' do

      @customer = FactoryGirl.create(:customer)
      @location = FactoryGirl.create(:location)

      visit new_pick_up_path

      select 'New Location', from: "pick_up_location_id"
      select 'New Customer', from: "pick_up_customer_id"
      fill_in "Item", with: "Item first"
      select "5", from: "Quantity"

      click_button "Create Pick-up"

      expect(page).to have_content('New pick-up was successfully added!')
      expect(PickUp.count).to eq 1
    end

    scenario 'create location with no data' do
      visit new_pick_up_path

      click_button "Create Pick-up"

      expect(page).to have_content("Customer can't be blank")
      expect(page).to have_content("Location can't be blank")
      expect(page).to have_content("Item can't be blank")
      expect(page).to have_content("Quantity can't be blank")
      expect(PickUp.count).to eq 0
    end


  end
