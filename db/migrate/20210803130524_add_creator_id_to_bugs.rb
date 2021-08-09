class AddCreatorIdToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :creator_id, :integer
    add_index :bugs, :creator_id
    add_column :bugs, :assigned_user_id, :integer
  end
end
