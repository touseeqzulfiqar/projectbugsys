class AddFieldsToBugs < ActiveRecord::Migration[7.1]
  def change
    add_column :bugs, :deadline, :datetime
    add_column :bugs, :bug_type, :string
  end
end
