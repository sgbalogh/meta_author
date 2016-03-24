class AddProcessCountToRecords < ActiveRecord::Migration
  def change
    add_column :records, :processor_count, :integer
  end
end
