class AddExpectedReturnDateToLoans < ActiveRecord::Migration[7.0]
  def change
    add_column :loans, :expected_return_date, :date
  end
end
