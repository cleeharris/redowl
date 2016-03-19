class AddNonprofitToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :nonprofit_id, :integer
  end
end
