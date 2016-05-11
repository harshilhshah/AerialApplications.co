class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :fromId
      t.integer :toId
      t.integer :projectId
      t.string :message

      t.timestamps null: false
    end
  end
end
