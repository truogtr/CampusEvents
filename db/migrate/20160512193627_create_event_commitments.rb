class CreateEventCommitments < ActiveRecord::Migration

  def up
    create_table :event_commitments do |t|  # auto adds primary key, which we want
      t.references :user
      t.references :event
      t.string :description  # watch or attend;
          # note: can't use 'type' b/c it's a reserved keyword!
      t.timestamps null: false
    end
    add_index :event_commitments, ["user_id", "event_id"]
  end

  def down
    drop_table :event_commitments
  end

end
