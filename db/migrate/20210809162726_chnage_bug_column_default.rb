class ChnageBugColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:bugs, :title, from: '', to: nil)
  end
end
