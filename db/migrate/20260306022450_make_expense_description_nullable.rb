class MakeExpenseDescriptionNullable < ActiveRecord::Migration[8.1]
  def change
    change_column_null :expenses, :description, true
  end
end
