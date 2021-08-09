class DropBugsTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :bugs
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
