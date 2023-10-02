# == Schema Information
#
# Table name: loans
#
#  id          :bigint           not null, primary key
#  loan_date   :date
#  return_date :date
#  book_id     :bigint           not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  returned    :boolean          default(FALSE), not null
#
require "test_helper"

class LoanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
