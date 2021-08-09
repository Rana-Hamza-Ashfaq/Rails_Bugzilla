class AddAssignedIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :assign_id, :integer
  end
end
