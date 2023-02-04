FactoryBot.define do 
  factory :customer, aliases: [:user] do 

    transient do
      upcased { false }
      downcased { false }
      quantity_orders { 3 }
    end

    name { Faker::Name.name }
    email { name + "@gmail.com" }
    address { Faker::Address.street_address }

    trait :with_orders do 
      after(:create) do |customer, evaluator| 
        create_list(:order, evaluator.quantity_orders, customer: customer)
      end
    end
  
    trait :favorite do 
      sequence(:favorite, 'A') { |n| "Comida #{n}" }
    end

    trait :position do 
      sequence(:position) { |n| n }
    end

    trait :male do 
      gender { 'M' }
    end
    
    trait :female do 
      gender { 'F' }
    end
    
    trait :vip do 
      vip { true }
      days_to_pay { 30 }
    end
    
    trait :default do 
      vip { false }
      days_to_pay { 10 }
    end

    factory :customer_female_vip, traits: [:female, :vip]

    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end

    after(:build) do |customer, evaluator|
      customer.name.downcase! if evaluator.downcased
    end

  end
end