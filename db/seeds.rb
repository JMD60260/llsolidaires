# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Commencement des seeds\n "
puts "Nettoyage de la base de données en cours ..."
Rental.destroy_all
puts "Toutes les locations ont été effacées"
Flat.destroy_all
puts "Tous les appartements ont été supprimés"
User.destroy_all
puts "Tous les users ont été supprimés"

puts "Création de nouveaux utilisateurs"

puts "Création de Jean..."
owner1 = User.create!({
  email: "owner1@solidaires.com",
  password: "azerty",
  first_name: "Jean",
  last_name: "Dujardin",
  phone: "0612131415",
  role: 1
})

puts "Création de Pierre..."
owner2 = User.create!({
  email: "owner2@solidaires.com",
  password: "azerty",
  first_name: "Pierre",
  last_name: "Leloueur",
  phone: "0612131415",
  role: 1
})

puts "Création de Julio..."
owner3 = User.create!({
  email: "owner3@solidaires.com",
  password: "azerty",
  first_name: "Julio",
  last_name: "Solidaire",
  phone: "0612131415",
  role: 1
})

puts "Création de Phill..."
medic = User.create!({
  email: "medic@solidaires.com",
  password: "azerty",
  first_name: "Phill",
  last_name: "Collins",
  phone: "0623242526",
  role: 1
})

puts "Création de 3 appartements"

puts "Création du Studio..."
appart1 = Flat.create!({
  address: "17 rue du Paris, Paris 75017",
  flat_type: "Studio",
  description: "Charmant studio, 22m2, disponible pour vous reposer",
  accessibility_pmr: true,
  user_id: owner1.id
})

puts "Création du 3 pièces..."
appart2 = Flat.create!({
  address: "141 rue de Saint-Denis, Colombes 92210",
  flat_type: "3 pièces",
  description: "3 pièces, 59m2, deux chambres meublées, 1 salle de bain",
  accessibility_pmr: true,
  user_id: owner2.id
})

puts "Création du 2 pièces..."
appart3 = Flat.create!({
  address: "10 rue du port, Clichy 92110",
  flat_type: "2 pièces",
  description: "Charmant 2 pièces, 33m2 disponible pour vos reposer",
  accessibility_pmr: false,
  user_id: owner3.id
})

puts "Création d'une location"
Rental.create!({
  user_id: medic.id,
  flat_id: appart3.id,
  start_date: Date.new(2020,03,25),
  end_date: Date.new(2020,05,29)
})

puts " \nSeeds terminées avec succès"
