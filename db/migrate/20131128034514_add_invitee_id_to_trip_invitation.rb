class AddInviteeIdToTripInvitation < ActiveRecord::Migration
  def change
    add_column :trip_invitations, :invitee_id, :integer
  end
end
