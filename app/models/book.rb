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

    validates :title, presence: { message: "El título no puede estar en blanco" }
    validates :title, length: { minimum: 5, maximum: 200, message: "El título debe tener entre 5 y 200 caracteres." }

    validates :description, presence: { message: "La descripción no puede estar en blanco" }
    validates :description, length: { minimum: 5, maximum: 2000, message: "La descripción debe contener entre 5 y 2000 caracteres" }

    validates :image, presence: { message: "La imagen no puede ser nula" }

    validates :state, presence: { message: "El estado no puede se nulo" }

    validates :stock, presence: { message: "El stock no puede estar en blanco" }
    validates :stock, numericality: true
end
