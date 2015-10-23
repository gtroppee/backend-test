class CreatePhoneNumberAssignments < ActiveRecord::Migration
  def change
    create_table :phone_number_assignments do |t|
      t.string :callable_type
      t.integer :callable_id
      t.references :phone_number, index: true, foreign_key: true
      t.integer :priority

      t.timestamps null: false
    end
  end
end
