# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category

  # para validar que los inputs deben contener datos sino no te dejara pasar
  validates :name, :description, presence: :true
  # para validar que no exista duplicidad de datos en nombres, case_insensitive sirve para ver coincidencia con mayusculas y minusculas
  validates :name, uniqueness: {case_insensitive: false}
  # para validar un dato especifico tiene que ser en singular 
  validate :due_date_validaty

  def due_date_validaty
    return if due_date.blank?
    return if due_date > Date.today
    # para conectar con la internacionalización del idioma
    errors.add :due_date, i18n.t('task.errors.invalid_due_date')
  end
  
end
