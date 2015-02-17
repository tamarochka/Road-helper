require 'rails_helper'

feature 'user creates customer', %Q{
  As an authorized user
  I want to create new customer
  So that I can use it for a future pick-ups
} do

  before :each do
    @user = FactoryGirl.create(:user)
    login_as(@user)
  end

  scenario 'creates with valid data' do

    visit new_customer_path

    fill_in 'Name', with: "New Customer"
    fill_in 'Address', with: "333 Washington St, Boston, MA"

    click_button 'Create customer'

    expect(page).to have_content('New customer was successfully added!')
    expect(Customer.count).to eq 1
  end

  scenario 'create with invalid address' do
    visit new_customer_path

    fill_in 'Name', with: "New Customer"
    fill_in 'Address', with: "askjd,jh,jkj"

    click_button 'Create customer'

    expect(page).to have_content("Customer can't be added please check your address")
    expect(page).to have_content("Address is not valid")
    expect(Customer.count).to eq 0
  end

  scenario 'create customer with empty data' do
    visit new_customer_path

    click_button 'Create customer'

    expect(page).to have_content("Customer can't be added please check your address")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Address can't be blank")
    expect(Customer.count).to eq 0
  end


end
