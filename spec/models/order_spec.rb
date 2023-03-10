require 'rails_helper'

RSpec.describe Order, type: :model do
  it "Has one order" do 
    order = create(:order)
    expect(order.customer).to be_a(Customer)
  end

  it "Has one description" do 
    order = create(:order)
    expect(order.description).to start_with("Pedido número ")
  end

  it "Has 3 orders" do 
    orders = create_list(:order, 3)
    expect(orders.count).to eq(3)
  end

  it "Has 2 orders with create_pair" do 
    orders = create_pair(:order)
    expect(orders.count).to eq(2)
  end

  it "Has a list of attributes for orders" do 
    orders = attributes_for_list(:order, 5)
    expect(orders.count).to eq(5)
  end

  it "Has a stub of order that has not real objects and do not real functions" do 
    expect { build_stubbed(:order) }.not_to change{ Order.all.size }   
  end
end
