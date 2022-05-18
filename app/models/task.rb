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
#  owner_id    :bigint           not null
#  code        :string
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user

  validates :participating_users, presence: true
  # para validar que los inputs deben contener datos sino no te dejara pasar
  validates :name, :description, presence: true
  # para validar que no exista duplicidad de datos en nombres, case_insensitive sirve para ver coincidencia con mayusculas y minusculas
  validates :name, uniqueness: {case_insensitive: false}
  # para validar un dato especifico tiene que ser en singular 
  validate :due_date_validaty

  before_create :create_code
  after_create :send_email

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  def due_date_validaty
    return if due_date.blank?
    return if due_date > Date.today
    # para conectar con la internacionalización del idioma
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end

  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def send_email
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_email.deliver!
      
    end
  end
  
  
  
end
