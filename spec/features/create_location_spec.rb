require 'rails_helper'

feature 'user creates location', %Q{
  As an authorized user
  I want to create new location
  So that I can use it for a future pick-ups
} do

  before :each do
    @user = FactoryGirl.create(:user)
    login_as(@user)
  end

  scenario 'creates with valid data' do

    visit new_location_path

    fill_in 'Name', with: "New Location"
    fill_in 'Address', with: "33 Harrison Ave, Boston, MA"

    click_button 'Create location'

    expect(page).to have_content('New location was successfully added!')
    expect(Location.count).to eq 1
  end

  scenario 'create with invalid address' do
    visit new_location_path

    fill_in 'Name', with: "New Location"
    fill_in 'Address', with: "askjd,jh,jkj"

    click_button 'Create location'

    expect(page).to have_content("Location can't be added please check your address")
    expect(page).to have_content("Address is not valid")
    expect(Location.count).to eq 0
  end

  scenario 'create location with no data' do
    visit new_location_path

    click_button 'Create location'

    expect(page).to have_content("Location can't be added please check your address")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(Location.count).to eq 0
  end


end
