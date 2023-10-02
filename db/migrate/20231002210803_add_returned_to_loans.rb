class AddReturnedToLoans < ActiveRecord::Migration[7.0]
  def change
    add_column :loans, :returned, :boolean, null: false, default: false
  end
end
