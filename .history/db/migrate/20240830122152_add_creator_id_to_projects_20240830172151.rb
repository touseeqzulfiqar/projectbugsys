class AddCreatorIdToProjects < ActiveRecord::Migration[7.1]
  def change
    add_reference :projects, :creator_id, null: false, foreign_key: true
  end
end
