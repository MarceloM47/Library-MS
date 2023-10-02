class AddForeignKeyToLoans < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key(:loans, :books) if foreign_key_exists?(:loans, :books)
    add_foreign_key(:loans, :books, column: :book_id, on_delete: :cascade)
  end
end
