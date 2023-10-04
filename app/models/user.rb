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
  has_many :loans, dependent: :nullify

  def has_pending_loan?
    loans.exists?(returned: false)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  validates :email, presence: { message: "El email no puede estar vacío" }
  validates :name, presence: { message: "El nombre no puede estar vacío" }
  validates :lastname, presence: { message: "El apellido no puede estar vacío" }
  validates :dni, presence: { message: "El CI no puede estar vacío" }, numericality: { only_integer: true, message: "El CI debe ser un número válido" }
  validates :phone_number, presence: { message: "El Número de teléfono no puede estar vacío" }, numericality: { only_integer: true, message: "El Número de teléfono debe ser un número válido" }
  validates :speciality_id, presence: { message: "La especialidad no puede estar vacío" }

end
