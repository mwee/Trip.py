class AddBudgetInMinToUser < ActiveRecord::Migration
  def change
    add_column :users, :budget_in_min, :float
  end
end
