# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  has_many :tasks
  # para validar que los inputs deben contener datos sino no te dejara pasar
  validates :name, :description, presence: :true
  # para validar que no exista duplicidad de datos en nombres, case_insensitive sirve para ver coincidencia con mayusculas y minusculas
  validates :name, uniqueness: {case_insensitive: false}
end
