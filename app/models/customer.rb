class Customer < ApplicationRecord
  has_many :orders
  def fullname 
    "Sr. #{name}"
  end
end
