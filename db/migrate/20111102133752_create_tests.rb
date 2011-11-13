class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :required1
      t.string :required2
      t.string :optional1
      t.string :optional2
      t.boolean :marked

      t.timestamps
    end
  end
end
