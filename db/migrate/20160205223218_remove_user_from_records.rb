class RemoveUserFromRecords < ActiveRecord::Migration
  def change
    remove_column :records, :user, :integer
  end
end
