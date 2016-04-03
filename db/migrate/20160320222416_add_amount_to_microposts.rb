class AddAmountToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :amount, :decimal, :precision => 2
  end
end
