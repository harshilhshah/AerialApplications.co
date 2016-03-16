class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :user
      t.string :url
      t.string :type

      t.timestamps null: false
    end
  end
end
