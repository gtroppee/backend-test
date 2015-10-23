class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :sip_endpoint
      t.string :callable_type
      t.integer :callable_id

      t.timestamps null: false
    end
  end
end
