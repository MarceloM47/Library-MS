class AddSpecialityToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :speciality, foreign_key: true, default: nil
  end
end
