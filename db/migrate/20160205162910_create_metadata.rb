class CreateMetadata < ActiveRecord::Migration
  def change
    create_table :metadata do |t|
      t.integer :record_id
      t.string :metadata_key
      t.string :metadata_value
      t.string :schema

      t.timestamps null: false
    end
  end
end
