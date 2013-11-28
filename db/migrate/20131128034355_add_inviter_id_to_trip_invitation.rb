class AddInviterIdToTripInvitation < ActiveRecord::Migration
  def change
    add_column :trip_invitations, :inviter_id, :integer
  end
end
