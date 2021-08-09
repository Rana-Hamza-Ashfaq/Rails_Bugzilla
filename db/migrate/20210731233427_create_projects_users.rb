class CreateProjectsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :projects_users, id: false do |t|
      t.integer :project_id
      t.integer :user_id
    end
  end
end
