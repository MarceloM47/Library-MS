# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :string
#  state       :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#  stock       :integer          default(1)
#  slug        :string
#
require "test_helper"

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
