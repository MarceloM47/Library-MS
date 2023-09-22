class AddStockToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :stock, :integer, default: 1
  end
end
