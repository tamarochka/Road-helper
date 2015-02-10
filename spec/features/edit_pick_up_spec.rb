require 'rails_helper'

feature 'user updates pick-up', %Q{
  As an authorized user
  I want to update an existing pick-up
  So that it has current data
} do

  scenario 'updates pick-up' do

    @pick_up =FactoryGirl.create(:pick_up)
    user = @pick_up.user
    login_as(user)

    visit edit_pick_up_path(@pick_up)

    select "1", from: "Quantity"
    click_on 'Update'

    visit pick_up_path(@pick_up)

    expect(page).to have_content('5')

  end
end
