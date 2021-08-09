class AddProjectIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :project_id, :integer
    add_index :bugs, :project_id
  end
end
