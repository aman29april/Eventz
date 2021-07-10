class CreateClockEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :clock_events do |t|
      t.string :username,     null: false, index: true
      t.boolean :event_type,  null: false
      t.datetime :event_at,   null: false

      t.timestamps
    end
  end
end
