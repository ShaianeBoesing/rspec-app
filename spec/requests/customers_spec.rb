require 'rails_helper'

RSpec.describe "Customers", type: :request do
  include Devise::Test::IntegrationHelpers
  describe "GET /index" do

    context 'As Guest' do 
      describe "#index" do
        it "responds a 200 response" do
          get customers_path
          expect(response.status).to eq(200)
        end
      end
  
      describe "#show" do
        it "responds a 302 response (not authorized)" do
          customer = create(:customer)
          get customer_path customer.id
          expect(response.status).to eq(302)
        end
      end
    end

    context 'As Logged Member' do 
      describe "#show" do 
        before do 
          member = create(:member)
          sign_in member
          @customer_params = attributes_for(:customer)
          @customer = create(:customer)
        end

        it 'with valid attrs' do 
          expect { post customers_path, params: { customer: @customer_params } }.to change(Customer, :count).by(1)
        end

        it 'with invalid attrs' do 
          customer_params = attributes_for(:customer, address: nil)
          expect { post customers_path, params: { customer: customer_params } }.not_to change(Customer, :count)
        end

        it 'flash notice' do 
          post customers_path, params: { customer: @customer_params } 
          expect(flash[:notice]).to match(/successfully created/)
        end

        it 'content-type' do 
          get "/customers/#{@customer.id}", as: :json
          expect(response.content_type).to match(/application\/json/)
        end

        it "responds a 200 response" do
          get customer_path @customer.id
          expect(response.status).to eq(200)
        end

        it "render a :show template" do
          get customer_path @customer.id
          expect(response).to render_template("show")
        end
      end
    end
  end
end
