class CreateProjectStatusTypes < ActiveRecord::Migration
  def change
    create_table :project_status_types do |t|
      t.string :description
      t.string :name

      t.timestamps null: false
    end
  end
end
