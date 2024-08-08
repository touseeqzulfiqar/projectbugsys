class AddUserIdToBugs < ActiveRecord::Migration[7.1]
  def change
    add_reference :bugs, :user, foreign_key: true
  end
end
