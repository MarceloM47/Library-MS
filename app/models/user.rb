# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  lastname               :string           not null
#  dni                    :integer          not null
#  phone_number           :integer          not null
#  admin                  :boolean          default(FALSE), not null
#  active                 :boolean          default(FALSE), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  speciality_id          :bigint
#
class User < ApplicationRecord
  belongs_to :speciality
  has_many :loans
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
