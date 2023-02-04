class Customer < ApplicationRecord
  has_many :orders
  validates :address, presence: true

  def fullname 
    "Sr. #{name}"
  end
end
