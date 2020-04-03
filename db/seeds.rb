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
Hospital.destroy_all
puts "Tous les hopitaux ont été supprimés"

puts "Création de nouveaux utilisateurs"

puts "Création de Jean...(propriétaire)"
owner1 = User.create!({
  email: "owner1@solidaires.com",
  password: "azerty",
  first_name: "Jean",
  last_name: "Dujardin",
  phone: "0612131415",
  role: "owner"
})

puts "Création de Pierre...(propriétaire)"
owner2 = User.create!({
  email: "owner2@solidaires.com",
  password: "azerty",
  first_name: "Pierre",
  last_name: "Leloueur",
  phone: "0612131415",
  role: "owner"
})

puts "Création de Julio...(propriétaire)"
owner3 = User.create!({
  email: "owner3@solidaires.com",
  password: "azerty",
  first_name: "Julio",
  last_name: "Solidaire",
  phone: "0612131415",
  role: "owner"
})

puts "Création de Phill...(Medic)"
medic = User.create!({
  email: "medic@solidaires.com",
  password: "azerty",
  first_name: "Phil",
  last_name: "Collins",
  phone: "0623242526",
  role: "medical"
})

puts "Création de 21 appartements (environ 40 secondes)"

puts "Création de 9 Studios...-> Owner 1"
appart1 = Flat.create!({
  address: "42 rue de la Harpe, Paris 75005",
  city: "Paris",
  flat_type: "T1",
  description: "Charmant studio, 22m2, disponible pour vous reposer",
  accessibility_pmr: true,
  user_id: owner1.id
})
sleep(2)
appart2 = Flat.create!({
  address: "45 rue de la Harpe, Paris 75005",
  city: "Paris",
  flat_type: "T1",
  description: "Studio charmant, 23m2, disponible pour le repose du personnel médical",
  accessibility_pmr: true,
  user_id: owner1.id
})
sleep(1)
appart3 = Flat.create!({
  address: "6 rue Xavier Privas, Paris 75005",
  city: "Paris",
  flat_type: "T1",
  description: "Studio charmant, 15m2, disponible pour vous reposer",
  accessibility_pmr: true,
  user_id: owner1.id
})
sleep(2)
appart4 = Flat.create!({
  address: "28 rue de la Huchette, Paris 75005",
  city: "Paris",
  flat_type: "T1",
  description: "Studio charmant, 16m2",
  accessibility_pmr: true,
  user_id: owner1.id
})
sleep(1)
appart5 = Flat.create!({
  address: "53 Rue du Metz, 59800 Lille",
  city: "Lille",
  flat_type: "T1",
  description: "Studio charmant, 17m2",
  accessibility_pmr: true,
  user_id: owner1.id
})
sleep(2)
appart6 = Flat.create!({
  address: "26 Rue Kervégan, 44000 Nantes",
  city: "Nantes",
  flat_type: "T1",
  description: "Studio charmant, 18m2",
  accessibility_pmr: true,
  user_id: owner1.id
})
sleep(1)
appart19 = Flat.create!({
  address: "82 Rue de la Balme, 69003 Lyon",
  city: "Lyon",
  flat_type: "T1",
  description: "Studio charmant, 19m2",
  accessibility_pmr: true,
  user_id: owner1.id
})
sleep(2)
appart20 = Flat.create!({
  address: "24 Rue du Capitaine, 69003 Lyon",
  city: "Lyon",
  flat_type: "T1",
  description: "Studio charmant, 20m2",
  accessibility_pmr: true,
  user_id: owner1.id
})
sleep(1)
appart21 = Flat.create!({
  address: "69 Rue Jeanne d'Arc, 69003 Lyon",
  city: "Lyon",
  flat_type: "T1",
  description: "Studio charmant, 21m2",
  accessibility_pmr: true,
  user_id: owner1.id
})

puts "Création de 5 appartements 3 pièces...->Owner2"
sleep(2)
appart7 = Flat.create!({
  address: "35 avenue du parc, Saint-Leu la forêt 95320",
  city: "Saint-Leu la forêt",
  flat_type: "T3",
  description: "3 pièces, 59m2, deux chambres meublées, 1 salle de bain",
  accessibility_pmr: true,
  user_id: owner2.id
})
sleep(1)
appart8 = Flat.create!({
  address: "86 Rue Princesse, 59800 Lille",
  city: "Lille",
  flat_type: "T3",
  description: "3 pièces, 60m2",
  accessibility_pmr: true,
  user_id: owner2.id
})
sleep(1)
appart9 = Flat.create!({
  address: "21 Rue Saint-Sébastien, 59800 Lille",
  city: "Lille",
  flat_type: "T3",
  description: "3 pièces, 50m2",
  accessibility_pmr: true,
  user_id: owner2.id
})
sleep(2)
appart10 = Flat.create!({
  address: "12 Allée de la Maison Rouge, 44000 Nantes",
  city: "Nantes",
  flat_type: "T3",
  description: "3 pièces, 51m2",
  accessibility_pmr: true,
  user_id: owner2.id
})
sleep(1)
appart11 = Flat.create!({
  address: "2 Rue du Chêne d'Aron, 44000 Nantes",
  city: "Nantes",
  flat_type: "T3",
  description: "3 pièces, 53m2",
  accessibility_pmr: true,
  user_id: owner2.id
})
sleep(1)
puts "Création de 7 appartements 2 pièces...--> Owner3"
appart12 = Flat.create!({
  address: "10 rue du port, Clichy 92110",
  city: "Clichy",
  flat_type: "T2",
  description: "Charmant 2 pièces, 33m2 disponible pour vos reposer",
  accessibility_pmr: false,
  user_id: owner3.id
})
sleep(2)
appart13 = Flat.create!({
  address: "13 Rue Commandant Mages, 13001 Marseille",
  city: "Marseille",
  flat_type: "T2",
  description: "Charmant 2 pièces, 33m2",
  accessibility_pmr: false,
  user_id: owner3.id
})
sleep(1)
appart14 = Flat.create!({
  address: "40 Boulevard Dahdah, 13004 Marseille",
  city: "Marseille",
  flat_type: "T2",
  description: "Charmant 2 pièces, 34m2",
  accessibility_pmr: false,
  user_id: owner3.id
})
sleep(2)
appart15 = Flat.create!({
  address: "1 Boulevard Léglize, 13004 Marseille",
  city: "Marseille",
  flat_type: "T2",
  description: "Charmant 2 pièces, 35m2",
  accessibility_pmr: false,
  user_id: owner3.id
})
sleep(1)
appart16 = Flat.create!({
  address: "11 Boulevard Léglize, 13004 Marseille",
  city: "Marseille",
  flat_type: "T2",
  description: "Charmant 2 pièces, 36m2",
  accessibility_pmr: false,
  user_id: owner3.id
})
sleep(1)
appart17 = Flat.create!({
  address: "11 rue Malherbe, 44000 Nantes",
  city: "Nantes",
  flat_type: "T2",
  description: "Charmant 2 pièces, 37m2",
  accessibility_pmr: false,
  user_id: owner3.id
})
sleep(2)
appart18 = Flat.create!({
  address: "74 Rue de la Balme, 69003 Lyon",
  city: "Lyon",
  flat_type: "T2",
  description: "Charmant 2 pièces, 38m2",
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

# puts "Création d'un hopital"
#   Hospital.create!({
#     address: "100 Boulevard du Général Leclerc 92110 Clichy",
#     name: "Hôpital Beaujon AP-HP"
#   })

# puts "Création d'un hopital"
#   Hospital.create!({
#     address: "178 Rue des Renouillers, 92700 Colombes",
#     name: "Hôpital Louis-Mourier AP-HP"
#   })

puts " \nSeeds terminées avec succès"
