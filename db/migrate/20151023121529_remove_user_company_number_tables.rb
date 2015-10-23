class RemoveUserCompanyNumberTables < ActiveRecord::Migration
  def change
    drop_table :user_numbers
    drop_table :company_numbers
  end
end
