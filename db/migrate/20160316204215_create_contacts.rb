class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.string :message

      t.timestamps null: false
    end
  end
end