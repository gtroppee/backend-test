class AddIndexes < ActiveRecord::Migration
  def change
    add_index :phone_numbers, :sip_endpoint
    add_index :phone_numbers, :type
    add_index :calls, :uid
  end
end
