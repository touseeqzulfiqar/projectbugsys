class AddCreatorIdToProjects < ActiveRecord::Migration[7.1]
  def change
    add_reference :projects, :creator_id, foreign_key: { to_table: :users }
  end
end
