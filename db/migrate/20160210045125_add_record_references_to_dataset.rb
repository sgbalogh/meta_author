class AddRecordReferencesToDataset < ActiveRecord::Migration
  def change
    add_reference :datasets, :record, index: true, foreign_key: true
  end
end
