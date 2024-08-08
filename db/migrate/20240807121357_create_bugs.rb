class CreateBugs < ActiveRecord::Migration[7.1]
  def change
    create_table :bugs do |t|
      t.belongs_to :project
      t.string :description
      t.string :status
      t.timestamps
    end
  end
end
