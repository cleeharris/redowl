class CreateNprelations < ActiveRecord::Migration
  def change
    create_table :nprelations do |t|
      t.integer :user_id
      t.integer :nonprofit_id

      t.timestamps null: false
    end
    add_index :nprelations, :user_id
    add_index :nprelations, :nonprofit_id
    add_index :nprelations, [:user_id, :nonprofit_id], unique: true
  end
end
