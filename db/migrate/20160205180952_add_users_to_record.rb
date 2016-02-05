class AddUsersToRecord < ActiveRecord::Migration
  def change
    add_column :records, :user, :integer
  end
end
