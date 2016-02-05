class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :schema

      t.timestamps null: false
    end
  end
end
