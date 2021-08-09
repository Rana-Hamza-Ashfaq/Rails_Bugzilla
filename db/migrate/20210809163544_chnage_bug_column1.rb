class ChnageBugColumn1 < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :title, :string, { null: false, presence: true }
  end
end
