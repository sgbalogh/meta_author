class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :attachment
      t.timestamps null: false
    end
  end
end
