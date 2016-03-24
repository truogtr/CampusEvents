class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string "event_name", :limit => 50
      t.string "location"
    	t.text "event_description"
    	t.datetime "start_time"
      t.datetime "end_time"
    	t.string "category"
    	t.integer "creator_id"
    	t.boolean "visible", :default => false

      t.timestamps null: false
    end
  end
end
