
class NewCustomerForm 
  include Capybara::DSL
  include FactoryBot::Syntax::Methods
  include Warden::Test::Helpers
  include Rails.application.routes.url_helpers

  def login 
    member = create(:member)
    login_as(member, :scope => :member)
    self
  end

  def visit_page 
    visit(new_customer_path)
    self
  end

  def fill_in_with(params = {})
    attrs = attributes_for(:customer)
    fill_in('Name', with: params.fetch(:name, attrs[:name]))
    fill_in('Email', with: params.fetch(:email, attrs[:email]))
    fill_in('Address', with: params.fetch(:address, attrs[:address]))
    self
  end

  def submit 
    click_button('Create Customer')
  end
end