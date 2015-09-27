require 'rails_helper'

describe 'can view an item show page', type: :feature do
  let(:item) { Item.last }

  before(:each) do
   Item.create(name: "Soda", description: "Teh bubbles", price:100)
   User.create(email: "david@example.com", password: "password")
  end

  def enter_address
    fill_in("First Name", with: "Josha")
    fill_in("Last Name", with: "Mejia")
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")
    click_on("Check Out")
  end

  scenario 'from the item index' do
    visit items_path
    click_on "Soda"

    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('100')
  end

  scenario 'from the cart' do
    visit items_path
    click_on "Add Soda"
    click_on "Cart"
    click_on "Soda"

    expect(current_path).to eq(item_path(item))

    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('100')
  end

  scenario 'from past orders' do
    visit items_path
    click_on "Add Soda"
    click_on "Cart"
    click_on "Check Out"

    fill_in "Email", with: "david@example.com"
    fill_in "Password", with: "password"

    click_button("Login")
    click_button("Check Out")
    enter_address
    click_on "Soda"
    
    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('100')
  end
end
