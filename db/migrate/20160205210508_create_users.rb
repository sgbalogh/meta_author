class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :institution
      t.string :division
      t.string :email

      t.timestamps null: false
    end
  end
end
