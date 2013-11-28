class AddTripIdToTripInvitation < ActiveRecord::Migration
  def change
    add_column :trip_invitations, :trip_id, :integer
  end
end
