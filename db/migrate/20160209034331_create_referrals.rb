class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :referringUserId
      t.integer :referredUserId

      t.timestamps null: false
    end
  end
end
