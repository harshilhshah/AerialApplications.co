class AddUserOtherInfoColumns < ActiveRecord::Migration
  def change
      add_column :users, :address1, :string
      add_column :users, :address2, :string
      add_column :users, :phone, :string
      add_column :users, :city, :string
      add_column :users, :state, :string
      add_column :users, :phoneType, :integer     
  end
end
