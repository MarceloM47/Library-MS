# == Schema Information
#
# Table name: specialities
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Speciality < ApplicationRecord
    has_many :users
end
