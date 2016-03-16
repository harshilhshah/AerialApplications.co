class CreateProjectStatuses < ActiveRecord::Migration
  def change
    create_table :project_statuses do |t|
      t.integer :projectId
      t.integer :owner
      t.integer :statusId
      t.string :comment

      t.timestamps null: false
    end
  end
end
