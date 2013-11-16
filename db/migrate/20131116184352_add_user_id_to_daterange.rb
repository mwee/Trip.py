class AddUserIdToDaterange < ActiveRecord::Migration
  def change
    add_column :dateranges, :user_id, :integer
  end
end
