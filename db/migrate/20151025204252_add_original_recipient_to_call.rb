class AddOriginalRecipientToCall < ActiveRecord::Migration
  def change
    add_column :calls, :original_recipient_sip, :string
  end
end
