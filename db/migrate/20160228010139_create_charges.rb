class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.float :amount
      t.integer :customer_id
      t.boolean :refunded
      t.string :last_four

      t.timestamps null: false
    end
  end
end
