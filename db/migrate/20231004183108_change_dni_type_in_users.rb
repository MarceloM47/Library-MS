class ChangeDniTypeInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :dni, :string
  end
end
