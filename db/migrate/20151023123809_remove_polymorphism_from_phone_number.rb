class RemovePolymorphismFromPhoneNumber < ActiveRecord::Migration
  def change
    remove_column :phone_numbers, :callable_type
    remove_column :phone_numbers, :callable_id
  end
end
