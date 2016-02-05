class AddIndicesToRecords < ActiveRecord::Migration
  def change
    add_index :records, [:user_id, :created_at]
  end
end
