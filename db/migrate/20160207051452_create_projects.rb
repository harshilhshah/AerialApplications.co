class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :customerId
      t.integer :affiliateId
      t.string :address
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.datetime :due
      t.integer :projectTypeId
      t.integer :owner

      t.timestamps null: false
    end
  end
end
