class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :answered_at
      t.string   :direction
      t.integer  :duration, default: 0
      t.string   :status
      t.string   :uid
      t.float    :cost, default: 0
      t.float    :rate
      t.string   :caller_sip
      t.string   :recipient_sip
      t.string   :caller_name
      t.text     :record_url
      t.integer  :record_length

      t.timestamps null: false
    end
  end
end
