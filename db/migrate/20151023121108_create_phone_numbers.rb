class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :sip_endpoint
      t.string :type

      t.timestamps null: false
    end
  end
end
