require 'rails_helper'

feature 'user updates location', %Q{
  As an authorized user
  I want to update an existing location
  So that it has current data
} do

  scenario 'updates location' do

    @location =FactoryGirl.create(:location)
    user = @location.user
    login_as(user)

    visit edit_location_path(@location)

    fill_in "Name", with: "Updated Name"
    click_on 'Update'

    visit locations_path

    expect(page).to have_content('Updated Name')

  end
end
