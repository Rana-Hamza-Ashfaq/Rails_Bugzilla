class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :description
      t.date :due_date
      t.string :bugtype
      t.string :status

      t.timestamps
    end
  end
end
