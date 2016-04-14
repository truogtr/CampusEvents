class CreateEventsUsersJoin < ActiveRecord::Migration
  def change
    # id => false because it is a simple join table
    # but we might need to put the id there again and make it a
    # rich join table!
    create_table :events_users, :id => false do |t|
      t.integer 'user_id'
      t.integer 'event_id'
    end
    add_index :events_users, ["user_id", "event_id"]
  end
end
