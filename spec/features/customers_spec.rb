require 'rails_helper'

RSpec.feature "Customers", type: :feature, js: true do
  it "Visit index page" do 
    visit(customers_path)
    #save_and_open_page
    #page.save_screenshot('my_screenshot.png')
    expect(page).to have_current_path(customers_path)
  end

  it "AJAX" do 
    visit(customers_path)
    click_link('Add Message')
    expect(page).to have_content("Yes!")
  end

  it "Creates a Customer" do 
      member = create(:member)
      login_as(member, :scope => :member)
      attrs = attributes_for(:customer)
      puts attrs
      visit(new_customer_path)
      fill_in('Name', with: attrs[:name])
      fill_in('Email', with: attrs[:email])
      fill_in('Address', with: attrs[:address])

      click_button('Create Customer')
      expect(page).to have_content('Customer was successfully created')
    end
end
