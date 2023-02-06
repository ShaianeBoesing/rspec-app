require 'rails_helper'

RSpec.describe "Customers", type: :request do
  include Devise::Test::IntegrationHelpers
  describe "GET /index" do

    let(:customer) { create(:customer) }
    let(:member) { create(:member) }

    context 'As Guest' do 
      describe "#index" do
        it "responds a 200 response" do
          get customers_path
          expect(response.status).to eq(200)
        end
      end
  
      describe "#show" do
        it "responds a 302 response (not authorized)" do
          get customer_path customer.id
          expect(response.status).to eq(302)
        end
      end
    end

    context 'As Logged Member' do 
      describe "#show" do 
        before do 
          sign_in member
          @customer_params = attributes_for(:customer)
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
          get customer_path(customer.id), as: :json
           expect(response.content_type).to match(/application\/json/)
        end

        it "responds a 200 response" do
          get customer_path customer.id
          expect(response.status).to eq(200)
        end

        it "render a :show template" do
          get customer_path customer.id
          expect(response).to render_template("show")
        end
      end
    end
  
    context 'API tests' do 
      
      let(:headers) { {"ACCEPT" => "application/json"} }
      
      before do 
        sign_in member
      end

      it "JSON Schema Matchers" do 
        get customer_path(customer.id) , as: :json
        expect(response).to match_response_schema("customer")
      end


      it "works! 200 OK" do 
        get customers_path
        expect(response).to have_http_status(200)
      end

      it "index - JSON" do 
        get customers_path, as: :json
        expect(response.body).to include_json([
          id: /\d/,
          name: (be_a String),
          email: (be_a String)
        ])
      end

      it "show - JSON" do 
        get customer_path(customer.id), as: :json
        expect(response.body).to include_json(
          id: /\d/,
          name: (be_a String),
          email: (be_a String)
        )
      end

      it "create - JSON" do 
        customer_attrs = attributes_for(:customer)
        post customers_path, params: { customer:customer_attrs }, headers: headers
        expect(response.body).to include_json(
          id: /\d/,
          name: customer_attrs.fetch(:name),
          email: customer_attrs.fetch(:email)
        )
      end

      it "update - JSON" do 
        customer = Customer.first
        customer.name += " - ATUALIZADO"
        patch customer_path(customer.id), params: { customer: customer.attributes }, headers: headers
        expect(response.body).to include_json(
          id: customer.id,
          name: match(/ - ATUALIZADO/),
          email: customer.email
        )
      end

      it "delete - JSON" do 
        customer = Customer.first
        expect { delete customer_path(customer.id) }.to change(Customer, :count).by(-1)
      end

      it "show - JSON with RSPEC puro" do 
        get customer_path(customer.id), as: :json
        response_body = JSON.parse(response.body) 
        expect(response_body).to include(
          "id" => customer.id,
          "name" => customer.name,
          "email" => customer.email,
        )
      end
    end
  end
end
