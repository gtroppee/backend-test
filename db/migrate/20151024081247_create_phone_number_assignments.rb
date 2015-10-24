class CreatePhoneNumberAssignments < ActiveRecord::Migration
  def change
    create_table :phone_number_assignments do |t|
      t.string :callable_type, index: true, null: false
      t.integer :callable_id, index: true, null: false
      t.references :phone_number, index: true, foreign_key: true
      t.integer :priority, null: false

      t.timestamps null: false
    end
  end
end
