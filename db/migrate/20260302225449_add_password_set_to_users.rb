class AddPasswordSetToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :password_set, :boolean, default: false, null: false
  end
end
