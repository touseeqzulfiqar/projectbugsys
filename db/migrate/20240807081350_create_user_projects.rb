class CreateUserProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :user_projects do |t|
      t.belongs_to :user, index: true
      t.belongs_to :project, index: true
      t.timestamps
    end
  end
end
