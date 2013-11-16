class AddBudgetOutMaxToUser < ActiveRecord::Migration
  def change
    add_column :users, :budget_out_max, :float
  end
end
