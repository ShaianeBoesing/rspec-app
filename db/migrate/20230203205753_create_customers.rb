class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.integer     :position
      t.string      :name
      t.string      :email
      t.boolean     :vip
      t.integer     :days_to_pay
      t.string      :gender
      t.string      :favorite
      t.string      :address
      
      t.timestamps
    end
  end
end
