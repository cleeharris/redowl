class AddNonprofitToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :nonprofit_id, :integer
    add_index :microposts, [:nonprofit_id]
  end
end
