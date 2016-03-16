class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :projectId
      t.string :title
      t.string :description
      t.string :filepath
      t.string :filetype
      t.integer :mediaTypeId

      t.timestamps null: false
    end
  end
end
