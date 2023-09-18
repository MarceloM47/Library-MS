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
#
class Book < ApplicationRecord
    has_one_attached :image
    has_many :loans
end
