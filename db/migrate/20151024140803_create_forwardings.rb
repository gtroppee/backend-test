class CreateForwardings < ActiveRecord::Migration
  def change
    create_table :forwardings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :call, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
