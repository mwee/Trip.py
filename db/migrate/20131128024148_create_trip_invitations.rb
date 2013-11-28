class CreateTripInvitations < ActiveRecord::Migration
  def change
    create_table :trip_invitations do |t|

      t.timestamps
    end
  end
end
