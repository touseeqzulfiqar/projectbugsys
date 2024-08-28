class AddTitleToBugs < ActiveRecord::Migration[7.1]
  def change
    add_column :bugs, :title, :string
  end
end
