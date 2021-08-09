class ChnageBugColumn2 < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :title, :string, presence: true
  end
end
