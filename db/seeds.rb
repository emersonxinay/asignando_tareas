# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# nombres de prueba
nombres = ['juan', 'andrea', 'leon', 'andres', 'natalia', 'camilo', 'rusbel', 'johan']

nombres.each do |name|

  User.create email: "#{name}@platzi.com", password: '123456'
  
  end
  
  puts 'Users has been created'

# categorias de prueba 
categorias = ['desarrollo', 'mercadeo', 'conceptualización', 'ejercicios']
  categorias.each do |name|

    Category.create name: name, description: '--'
    
    end
    
    puts 'Categories has been created'


# creando tareas y participante 

owner = User.find_by(email: 'johan@platzi.com')

# asociar la descripción y la categoría de la tarea
base = [

  [
  
  'conceptualización',
  
  'Bienvenida ',
  
  ['johan:1', 'leon:2', 'andrea:random']
  
  ],
  
  [
  
  'conceptualización',
  
  '¿Qué es ruby on rails y por qué usarlo?',
  
  ['johan:1', 'leon:2', 'andrea:random']
  
  ],
  
  [
  
  'conceptualización',
  
  'Entorno de desarrollo de RoR',
  
  ['johan:1', 'leon:2', 'andrea:random']
  
  ],
  
  [
  
  'ejercicios',
  
  'Instalación de Ruby, RoR en windows y Linux',
  
  ['johan:1', 'leon:2', 'andrea:random']
  
  ],
  
  ].each do |category, description, participant_set|

    participants = participant_set.map do |participant|
    
    user_name, raw_role = participant.split(':')
    
    role = raw_role == 'random' ? [1, 2].sample : raw_role
    
    Participant.new(
    
    user: User.find_by(email: "#{user_name}@platzi.com"),
    
    role: role.to_i
    
    )
    
    end
    
    Task.create!(
    
    category: Category.find_by(name: category),
    
    name: "Tarea ##{Task.count + 1}",
    
    description: description,
    
    due_date: Date.today + 15.days,
    
    owner: owner,
    
    participating_users: participants
    
    )
    
    end
    
    puts 'Tasks has been created'
    