class RemoveCreatorIdFromBug < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :creator_id
  end
end
