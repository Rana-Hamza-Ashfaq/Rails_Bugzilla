class RemoveAssignIdFromBug < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :assigned_user_id
  end
end
