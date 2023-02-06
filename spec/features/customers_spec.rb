require 'rails_helper'
require_relative '../support/new_customer_form'

RSpec.feature "Customers", type: :feature, js: true do
  it "Visit index page" do 
    visit(customers_path)
    save_and_open_page
    page.save_screenshot('my_screenshot.png')
    expect(page).to have_current_path(customers_path)
  end

  it "Ajax" do 
    visit(customers_path)
    click_link('Add Message')
    expect(page).to have_content("Yes!")
  end

  it "Find" do 
    visit(customers_path)
    click_link('Add Message')
    expect(find("#my-div").find("h1")).to have_content("Yes!")
  end

  it "Creates a Customer with Page Object Pattern" do 
    attrs = attributes_for(:customer)
   
    new_customer_form = NewCustomerForm.new 
    new_customer_form.login.visit_page.fill_in_with({
      name: attrs[:name],
      email: attrs[:email],
      address: attrs[:address]}
    ).submit

    expect(page).to have_content('Customer was successfully created')
  end

  it "Creates a Customer" do 
    member = create(:member)
    login_as(member, :scope => :member)
    attrs = attributes_for(:customer)
    visit(new_customer_path)
    fill_in('Name', with: attrs[:name])
    fill_in('Email', with: attrs[:email])
    fill_in('Address', with: attrs[:address])

    click_button('Create Customer')
    expect(page).to have_content('Customer was successfully created')
  end
end
