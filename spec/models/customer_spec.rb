require 'rails_helper'

RSpec.describe Customer, type: :model do
  
  it 'Create a Customer with factory' do 
    customers = create(:customer)
    expect(customers.fullname).to start_with("Sr. ")
  end

  it { expect { create(:customer) }.to change{ Customer.all.size }.by(1) }

  it "Create an Customer using alias for User" do 
    expect(create(:user)).to be_a(Customer)
  end

  it "Inherit: Customer with Subfactory to Vip Customer" do 
    expect(create(:user, :vip).vip).to be true
  end

  it "Inherit: Customer with Subfactory to Default Customer" do 
    expect(create(:user, :default).vip).to be false
  end

  it "Using attributes_for" do
    expect(attributes_for(:customer)).to include(:name, :email)
  end

  it "Using attributes_for trait vip" do
    expect(attributes_for(:customer, :vip)).to include(vip: true)
  end
  
  it "Using attributes_for trait default" do
    expect(attributes_for(:customer, :default)).to include(vip: false)
  end

  it "Using trasient for upcase after create" do
    customer = create(:customer, upcased: true)
    expect(customer.name.upcase).to eq(customer.name) 
  end

  it "Using trasient for capitalize after build" do
    customer = build(:customer, downcased: true)
    puts customer.name
    expect(customer.name.downcase).to eq(customer.name) 
  end

  it "Female Customer" do
    customer = create(:customer, :female)
    expect(customer.gender).to eq('F') 
  end

  it "Male Customer" do
    customer = create(:customer, :male)
    expect(customer.gender).to eq('M') 
  end

  it "Female Vip Customer with traits" do
    customer = create(:customer, :female, :vip)
    expect(customer).to have_attributes(gender: 'F', vip: true) 
  end

  it "Female Vip Customer with factories" do
    customer = create(:customer_female_vip)
    expect(customer).to have_attributes(gender: 'F', vip: true) 
  end

  it "Dynamic attrs, override and customize" do
    customer = create(:customer, name: "shai")
    expect(customer.email).to eq("shai@gmail.com") 
  end

  it "Testing sequence positions with numbers" do
    customer1 = create(:customer, :position)
    customer2 = create(:customer, :position)
    customer3 = create(:customer, :position)
    expect([customer1, customer2, customer3]).to match_array([
      have_attributes(position: 1),
      have_attributes(position: 2),
      have_attributes(position: 3)
    ])
  end

  it "Testing sequence foods with strings" do
    customer1 = create(:customer, :favorite)
    customer2 = create(:customer, :favorite)
    customer3 = create(:customer, :favorite)
    expect([customer1, customer2, customer3]).to match_array([
      have_attributes(favorite: "Comida A"),
      have_attributes(favorite: "Comida B"),
      have_attributes(favorite: "Comida C")
    ])
  end

  it "Customer with orders" do 
    customer = create(:customer, :with_orders)
    expect(customer.orders.count).to eq(3)
  end

  it "Customer with 5 orders" do 
    customer = create(:customer, :with_orders, quantity_orders: 5)
    expect(customer.orders.count).to eq(5)
  end

end

