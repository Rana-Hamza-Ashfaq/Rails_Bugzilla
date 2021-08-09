class ChangeColumnInProject < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :title, :string, { default: '', null: false }
  end
end
