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

    validates :name, presence: { message: "El nombre no puede ser nulo" }, uniqueness: { message: "El nombre ya existe" }
end
