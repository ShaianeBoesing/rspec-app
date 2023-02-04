FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido número #{n} - Meu pedido"}
    customer
  end
end
