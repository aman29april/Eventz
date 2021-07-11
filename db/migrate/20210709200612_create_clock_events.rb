class CreateClockEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :clock_events do |t|
      t.string    :username,      null: false, index: true
      t.boolean   :event_type,    null: false
      t.datetime  :clock_in_at,   null: false, index: true
      t.datetime  :clock_out_at
      t.float     :hours_clocked, default: 0.0

      t.timestamps
    end
  end
end
