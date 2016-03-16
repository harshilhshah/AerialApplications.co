class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :zipCode
      t.string :email
      t.string :username
      t.string :password_enc
      t.string :password
      t.string :salt
      t.integer :userTypeId
      t.integer :active
      t.integer :approved

      t.timestamps null: false
    end
  end
end
