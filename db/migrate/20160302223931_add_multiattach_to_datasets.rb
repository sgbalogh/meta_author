class AddMultiattachToDatasets < ActiveRecord::Migration
  def change
    add_column :datasets, :multiattach, :json
  end
end
