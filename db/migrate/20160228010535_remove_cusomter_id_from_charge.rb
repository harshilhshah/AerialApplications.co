class RemoveCusomterIdFromCharge < ActiveRecord::Migration
  def change
    remove_column :charges, :customer_id, :integer
  end
end
