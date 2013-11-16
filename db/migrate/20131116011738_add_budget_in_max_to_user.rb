class AddBudgetInMaxToUser < ActiveRecord::Migration
  def change
    add_column :users, :budget_in_max, :float
  end
end
