require 'rails_helper'

feature 'user deletes location', %Q{
  As an authorized user
  I want to delete an existing location
  So that it is no longer used in the system
} do

  scenario 'deletes location' do

    @location =FactoryGirl.create(:location)
    user = @location.user
    login_as(user)

    visit location_path(@location)

    click_on 'Delete'

    expect(page).to have_content('Location was successfully deleted!')
    expect(Location.count).to eq 0
  end
end
