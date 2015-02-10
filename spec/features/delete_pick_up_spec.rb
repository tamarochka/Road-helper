require 'rails_helper'

feature 'user deletes pick_up', %Q{
  As an authorized user
  I want to delete an existing pick-up
  So that it is no longer used in the system
} do

  scenario 'deletes pick-up' do

    @pick_up =FactoryGirl.create(:pick_up)
    user = @pick_up.user
    login_as(user)

    visit pick_up_path(@pick_up)

    click_on 'Delete'

    expect(page).to have_content('Pick-up was successfully deleted!')
    expect(PickUp.count).to eq 0
  end
end
