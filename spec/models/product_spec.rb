require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with description, price and category" do 
    product = create(:product)
    expect(product).to be_valid
  end

  context "Validations" do 
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:price) }
    it "must return error when description is blank" do 
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("can't be blank") 
    end
 end
  
  context "Associations" do 
    it { should belong_to(:category) }
  end

  context "Instance Methods" do
    describe "#full_description" do 
      it "must return a full description" do 
        product = create(:product)
        expect(product.full_description).to eq("#{product.description} - #{product.price}") 
      end
    end 
  end
end


