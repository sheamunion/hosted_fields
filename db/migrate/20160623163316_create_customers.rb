class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
    	t.string :first_name, null: false
    	t.string :last_name,  null: false
    	t.string :payment_method_nonce

    	t.timestamps
    end
  end
end
