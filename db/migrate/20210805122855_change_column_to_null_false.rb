class ChangeColumnToNullFalse < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :title, :string, { default: '', null: false }
  end
end
