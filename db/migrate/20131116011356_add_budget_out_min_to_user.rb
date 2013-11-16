class AddBudgetOutMinToUser < ActiveRecord::Migration
  def change
    add_column :users, :budget_out_min, :float
  end
end
