# == Schema Information
#
# Table name: loans
#
#  id                   :bigint           not null, primary key
#  loan_date            :date
#  return_date          :date
#  book_id              :bigint           not null
#  user_id              :bigint           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  returned             :boolean          default(FALSE), not null
#  expected_return_date :date
#
class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :loan_date, presence: true
  validates :expected_return_date, presence: false
end
